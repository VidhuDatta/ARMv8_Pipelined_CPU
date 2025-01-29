`timescale 1ns/10ps
module arithmetic_logic_unit(
	input clk,
	input reset,
	// control signals
	input AluSrc_Ctrl,
	input [1:0] ALURes_Ctrl,
	input [2:0] ALUOp_Ctrl,
	input IsImm_Ctrl,
	// pipeline registers
	input [159:0] REGFILE_PIPELINE_REG,
	output logic [159:0] ALU_PIPELINE_REG,
	// ALU flags
	output logic [3:0] ALUFlags,
	// Forwarding paths to RegFile
	output logic [63:0] ForwardingPath_To_REG,
	output logic [31:0] instr_in_exec_unit
);

// ALU INTERFACE SIGNALS
logic [63:0]	ALU_A, ALU_B;
logic [63:0] 	ALU_result, ADD_SUB_RESULT;
logic ALU_overflow, ALU_carry_out, ALU_negative, ALU_zero;

// internal signals
logic [63:0] ZE_IMM12, SE_DADDR9, IS_IMM_MUX_OUT, REG_FILE_ReadData2, REG_FILE_ReadData1, MUL_IN_Rn, MUL_IN_Rm, SHIFTER_OUT, SHIFTER_Rn, MUL_OUT_Rd;

// Unpack elements from the REGFILE_PIPELINE_REG
assign {REG_FILE_ReadData2, REG_FILE_ReadData1, instr_in_exec_unit} = REGFILE_PIPELINE_REG;

// First, decide what should be passed to the ALU's second input:
//		->	ZE(Imm12) OR
//		->	SE(DAddr9) OR
//		->	Reg[Rd/Rm]
// For ADDI:
// ADDI Rd, Rn, Imm12: 
// Reg[Rd] = Reg[Rn] + ZeroExtend(Imm12)
zero_extend #(.INPUT_BIT_WIDTH(12)) ZE_ADDI(instr_in_exec_unit[21:10], ZE_IMM12);

// For LDUR, STUR
// Addr = Reg[Rn] + SE(DAddr9);
sign_extend SE_LD_ST_UR(instr_in_exec_unit[20:12], SE_DADDR9);

// MUX1
mux_2x1_N IS_IMM_MUX(IS_IMM_MUX_OUT, IsImm_Ctrl, ZE_IMM12, REG_FILE_ReadData2);

mux_2x1_N ALU_SRC_MUX(ALU_B, AluSrc_Ctrl, SE_DADDR9, IS_IMM_MUX_OUT);

assign ALU_A = REG_FILE_ReadData1;

/*
	==========================================================
	=========================== ALU ==========================
	==========================================================
*/
alu ARITH_LOGIC_UNIT(
	.A(ALU_A),
	.B(ALU_B),
	.cntrl(ALUOp_Ctrl), // ALU_OP
	.result(ADD_SUB_RESULT),
	.negative(ALU_negative),
	.zero(ALU_zero),
	.overflow(ALU_overflow),
	.carry_out(ALU_carry_out));

assign ALUFlags = {ALU_overflow, ALU_carry_out, ALU_negative, ALU_zero};

// Shifter:
// LSL Rd, Rn, Shamt: 
//	Reg[Rd] = Reg[Rn] << Shamt
// LSR Rd, Rn, Shamt: 
//	Reg[Rd] = Reg[Rn] >> Shamt
/// USE "shifter" MODULE FROM math.sv
not #0.05(SHIFT_DIR, instr_in_exec_unit[21]); // OPCODES FOR "LSL" & "LSR" VARY IN 21st BIT
shifter SHIFT_LSL_LSR(
	.value(SHIFTER_Rn),
	.direction(SHIFT_DIR), // 0: left, 1: right
	.distance(instr_in_exec_unit[15:10]),
	.result(SHIFTER_OUT)
);
assign SHIFTER_Rn = REG_FILE_ReadData1;

// Multiplier
// MUL Rd, Rn, Rm: 
//	Reg[Rd] = (Reg[Rn]*Reg[Rm])[63:0]
// USE "mult" MODULE FROM math.sv
mult MUL_OP(
	.A(MUL_IN_Rn), 
	.B(MUL_IN_Rm),
	.doSigned(1'b1),				// 1: signed multiply | 0: unsigned multiply
	.mult_low(MUL_OUT_Rd)
);
assign MUL_IN_Rn = REG_FILE_ReadData1;
assign MUL_IN_Rm = REG_FILE_ReadData2;

// Decide Final ALU_result
/*
	ALU result:
	00 : ADD_SUB_RESULT
	01 : SHIFTER_OUT [LEFT]
	10 : SHIFTER_OUT [RIGHT]
	11 : MUL_OUT_Rd
*/
mux_4x1_N DECIDE_FINAL_ALU_OUT(ALU_result, ALURes_Ctrl, MUL_OUT_Rd, SHIFTER_OUT, SHIFTER_OUT, ADD_SUB_RESULT);

assign ForwardingPath_To_REG = ALU_result;

// ALU PIPELINE REGISTER
Register #(.WIDTH(160)) ALU_P_REG(
	.clk(clk),
	.reset(reset),
	.DataIn({instr_in_exec_unit, ALU_result, REG_FILE_ReadData2}),
	.WriteEnable(1'b1),
	.DataOut(ALU_PIPELINE_REG)
	);

endmodule