`include "math.sv"
`timescale 1ns/10ps

module datapath_pipelined(
	input clk,
	input reset,
	// Control Signals
	input RegWrite_Ctrl,
	input MemReg_Ctrl,
	input WrEnable_Ctrl,
	input RdEnable_Ctrl,
	input Reg2Loc_Ctrl,
	input IsImm_Ctrl,
	input AluSrc_Ctrl,
	input [2:0] ALUOp_Ctrl,
	input [1:0] ALURes_Ctrl,
	input UnCondBr_Ctrl,
	input BrTaken_Ctrl,
	// Forwarding Unit Control Signals
	input [1:0] FW_RegFile1_Ctrl,
	input [1:0] FW_RegFile2_Ctrl,
	output logic [3:0] ALUFlags,
	output logic IsRegRdZero,	// NEEDED BY CONTROL UNIT FOR CBZ INSTRUCTION
	output logic [31:0] instruction_out,
	output logic [31:0] instr_one_clock_before,
	output logic [31:0] instr_two_clocks_before
);

// REGISTER FILE INTERFACE SIGNALS
logic 	[4:0]  REG_FILE_WriteRegister;
logic 	[63:0] REG_FILE_WriteData;

// INTERNAL SIGNALS
logic [63:0] PC_COMPUTE_ADDER1_OUT, ForwardingPath_FromMEM_ToReg, ForwardingPath_FromALUToReg;

// PIPELINE REGISTERS
// (1) INSTRUCTION REGISTER. Contains:
//		->	Current PC value	: 64 BITS
//		->  Current Instruction	: 32 BITS
logic [95:0] INSTRUCTION_PIPELINE_REG;

// (2) REGFILE REGISTERS [REG/ DEC STAGE OUTPUTS]
logic [159:0] REGFILE_PIPELINE_REG; // 160

// (3) ALU REGISTER
logic [159:0] ALU_PIPELINE_REG; // 160

// (4) DATA REGISTERS
logic [223:0] MEMORY_DATA_PIPELINE_REG; // 224

//////////////////////// STAGE-1 [INSTRUCTION FETCH] //////////////////////////
instruction_fetch_unit IFU(
	.clk(clk),
	.reset(reset),
	.BranchAddress(PC_COMPUTE_ADDER1_OUT),
	.BrTaken_Ctrl(BrTaken_Ctrl),
	.INSTRUCTION_PIPELINE_REG(INSTRUCTION_PIPELINE_REG)
);

assign instruction_out = INSTRUCTION_PIPELINE_REG[31:0];

//////////////////////// STAGE-2 [REG/ DEC] ///////////////////////////////////
register_decode_unit RDU(
	.clk(clk),
	.reset(reset),
	.RegWrite_Ctrl(RegWrite_Ctrl),
	.Reg2Loc_Ctrl(Reg2Loc_Ctrl),
	.UnCondBr_Ctrl(UnCondBr_Ctrl),
	.FW_RegFile1_Ctrl(FW_RegFile1_Ctrl),
	.FW_RegFile2_Ctrl(FW_RegFile2_Ctrl),
	.REG_FILE_WriteData(REG_FILE_WriteData),
	.REG_FILE_WriteRegister(REG_FILE_WriteRegister),
	.ForwardingPath_FromMEM(ForwardingPath_FromMEM_ToReg),
	.ForwardingPath_FromALU(ForwardingPath_FromALUToReg),
	.IsRegRdZero(IsRegRdZero),
	.BRANCH_TARGET_ADDRESS(PC_COMPUTE_ADDER1_OUT),
	.INSTRUCTION_PIPELINE_REG(INSTRUCTION_PIPELINE_REG),
	.REGFILE_PIPELINE_REG(REGFILE_PIPELINE_REG)
);

//////////////////////// STAGE-3 [ALU] ////////////////////////////////////////
arithmetic_logic_unit AL_UNIT(
	.clk(clk),
	.reset(reset),
	.AluSrc_Ctrl(AluSrc_Ctrl),
	.ALURes_Ctrl(ALURes_Ctrl),
	.ALUOp_Ctrl(ALUOp_Ctrl),
	.IsImm_Ctrl(IsImm_Ctrl),
	.REGFILE_PIPELINE_REG(REGFILE_PIPELINE_REG),
	.ALU_PIPELINE_REG(ALU_PIPELINE_REG),
	.ALUFlags(ALUFlags),
	.ForwardingPath_To_REG(ForwardingPath_FromALUToReg),
	.instr_in_exec_unit(instr_one_clock_before)
);

//////////////////////// STAGE-4 [MEM] ////////////////////////////////////////
data_memory_unit DMU(
	.clk(clk),
	.reset(reset),
	.MemReg_Ctrl(MemReg_Ctrl),
	.RdEnable_Ctrl(RdEnable_Ctrl),
	.WrEnable_Ctrl(WrEnable_Ctrl),
	.ALU_PIPELINE_REG(ALU_PIPELINE_REG),
	.MEM_PIPELINE_REG(MEMORY_DATA_PIPELINE_REG),
	.ForwardingPath_To_REG(ForwardingPath_FromMEM_ToReg),
	.instr_in_dmem_unit(instr_two_clocks_before)
);

//////////////////////// STAGE-5 [WriteBack] //////////////////////////////////
write_back_unit WBU(
	.clk(clk),
	.reset(reset),
	.MEM_PIPELINE_REG(MEMORY_DATA_PIPELINE_REG),
	.REG_FILE_WriteData(REG_FILE_WriteData),
	.REG_FILE_WriteRegister(REG_FILE_WriteRegister)
);
endmodule