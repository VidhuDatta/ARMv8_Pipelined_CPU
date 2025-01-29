module register_decode_unit(
	input clk,
	input reset,
	// control signals
	input RegWrite_Ctrl,
	input Reg2Loc_Ctrl,
	input UnCondBr_Ctrl,
	input [1:0] FW_RegFile1_Ctrl,
	input [1:0] FW_RegFile2_Ctrl,
	// feedback paths to this unit
	input [63:0] REG_FILE_WriteData,
	input [63:0] ForwardingPath_FromMEM,
	input [63:0] ForwardingPath_FromALU,
	input [4:0] REG_FILE_WriteRegister,
	output logic IsRegRdZero,
	// feedback to PC compute logic
	output logic [63:0] BRANCH_TARGET_ADDRESS,
	// pipeline registers
	input [95:0] INSTRUCTION_PIPELINE_REG,
	output logic [159:0] REGFILE_PIPELINE_REG
);

// REGISTER FILE INTERFACE SIGNALS
logic 	[4:0]  REG_FILE_ReadRegister1;
logic 	[4:0]  REG_FILE_ReadRegister2;
logic 	[63:0] REG_FILE_ReadData1, REG_FILE_ReadData1_AfterFW;
logic 	[63:0] REG_FILE_ReadData2, REG_FILE_ReadData2_AfterFW;

// Other Internal Signals
logic 	[63:0] PC_Reg_Dec_Unit, UNCOND_BR_MUX_OUT, BR_SHIFT_OUT, PC_COMPUTE_ADDER1_OUT, SE_IMM26, SE_IMM19;

// Unpack Program Counter Value
assign PC_Reg_Dec_Unit = INSTRUCTION_PIPELINE_REG[95:32];

/*
	==========================================================
	================= REGISTER FILE ==========================
	==========================================================
*/
regfile REG_FILE(
	.clk(!clk), // IMPROVED REG FILE
	.ReadRegister1(REG_FILE_ReadRegister1),
	.ReadRegister2(REG_FILE_ReadRegister2),
	.WriteRegister(REG_FILE_WriteRegister),
	.WriteData(REG_FILE_WriteData),
	.RegWrite(RegWrite_Ctrl),
	.ReadData1(REG_FILE_ReadData1),
	.ReadData2(REG_FILE_ReadData2)
	);

// ASSIGN INSTRUCTION BITS TO INPUTS OF REG FILE
assign REG_FILE_ReadRegister1 = INSTRUCTION_PIPELINE_REG[9:5];
//assign REG_FILE_WriteRegister = INSTRUCTION_PIPELINE_REG[4:0];

mux_2x1_N #(.N(5)) REG_FILE_2_INP_DECIDE (REG_FILE_ReadRegister2, Reg2Loc_Ctrl, INSTRUCTION_PIPELINE_REG[20:16], INSTRUCTION_PIPELINE_REG[4:0]);

///////////////////////////// Accelerate Branches - START ///////////////////////////////////////
/*
	============== FEEDBACK PATH TO PROGRAM COUNTER [PART-2] ==========
*/
// UNCOND BRANCH PATH:
// B Imm26: PC = PC + SignExtend(Imm26 << 2)
sign_extend #(.INPUT_BIT_WIDTH(26)) SE_B_IMM26(INSTRUCTION_PIPELINE_REG[25:0],  SE_IMM26);
// COND BRANCH PATHS:
// (1) B.LT Imm19: 
//	If (flags.negative != flags.overflow) 
//		PC = PC + SignExtend(Imm19<<2)
//	else
//		PC = PC + 4;
//
// (2) CBZ Rd, Imm19: 
//	If (Reg[Rd] == 0) 
//		PC = PC + SignExtend(Imm19<<2)
//	else
//		PC = PC + 4;
sign_extend #(.INPUT_BIT_WIDTH(19)) SE_BLT_CBZ_IMM19(INSTRUCTION_PIPELINE_REG[23:5],  SE_IMM19);
mux_2x1_N UNCOND_BR_MUX(UNCOND_BR_MUX_OUT, UnCondBr_Ctrl, SE_IMM26, SE_IMM19);
assign BR_SHIFT_OUT = {UNCOND_BR_MUX_OUT[61:0], 2'b0};

Adder_64 PC_COMPUTE_ADDER1(
	.a(PC_Reg_Dec_Unit), // PROGRAM COUNTER
	.b(BR_SHIFT_OUT),
	.sum(PC_COMPUTE_ADDER1_OUT)
	);

assign BRANCH_TARGET_ADDRESS = PC_COMPUTE_ADDER1_OUT;

/*
	========== END OF FEEDBACK PATH TO PROGRAM COUNTER [PATH-2] =======
*/
///////////////////////////// Accelerate Branches - END /////////////////////////////////////////

///////////////////////////// Forwarding Unit - START ///////////////////////////////////////////
mux_4x1_N #(.N(64)) FWD_MUX_1 (REG_FILE_ReadData1_AfterFW, FW_RegFile1_Ctrl, 64'dx, ForwardingPath_FromALU, ForwardingPath_FromMEM, REG_FILE_ReadData1);
mux_4x1_N #(.N(64)) FWD_MUX_2 (REG_FILE_ReadData2_AfterFW, FW_RegFile2_Ctrl, 64'dx, ForwardingPath_FromALU, ForwardingPath_FromMEM, REG_FILE_ReadData2);

///////////////////////////// Forwarding Unit - END /////////////////////////////////////////////

/*
	================= PATH B/W REGFILE & ALU [PART-1] =================
*/
comp_N_1BitOut COMPUTE_IS_RD_ZERO(
	.A(REG_FILE_ReadData2_AfterFW),
	.B(64'd0),
	.result_eq(IsRegRdZero)
);
/*
	=============== END OF PATH B/W REGFILE & ALU [PART-1] ============
*/

///// REG/DEC REG /////
Register #(.WIDTH(160)) RD_P_REG(
	.clk(clk),
	.reset(reset),
	.DataIn({REG_FILE_ReadData2_AfterFW, REG_FILE_ReadData1_AfterFW, INSTRUCTION_PIPELINE_REG[31:0]}),
	.WriteEnable(1'b1),
	.DataOut(REGFILE_PIPELINE_REG) // OUTPUT INSTR FROM THE PIPELINE REGISTER
	);
endmodule