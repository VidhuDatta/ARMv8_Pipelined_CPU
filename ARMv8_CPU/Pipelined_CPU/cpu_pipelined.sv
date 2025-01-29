module cpu_pipelined(
	input clk,
	input reset // synchronous reset
);

//FLAGS
logic OVERFLOW, CARRYOUT, NEGATIVE, ZERO;

// FLAGS ARE 1 BIT REGISTERS (i.e., they need to have memory)
// THESE ARE UPDATED BY "S" INSTRUCTIONS ONLY & RETAIN THEIR VALUE FOR "B." INSTRUCTIONS TO USE THEM LATER ON.
D_FF_Enable OVERFLOW_REG(
	.d(OVERFLOW_FROM_ALU),
	.enb(flag_enable),
	.clk(clk),
	.reset(reset),
	.q(OVERFLOW));

D_FF_Enable CARRYOUT_REG(
	.d(CARRYOUT_FROM_ALU),
	.enb(flag_enable),
	.clk(clk),
	.reset(reset),
	.q(CARRYOUT));

D_FF_Enable NEGATIVE_REG(
	.d(NEGATIVE_FROM_ALU),
	.enb(flag_enable),
	.clk(clk),
	.reset(reset),
	.q(NEGATIVE));

D_FF_Enable ZERO_REG(
	.d(ZERO_FROM_ALU),
	.enb(flag_enable),
	.clk(clk),
	.reset(reset),
	.q(ZERO));

// Connections Datapath <-> Control path
logic [31:0] curr_instr, instr_one_clock_before, instr_two_clocks_before;
logic RegWrite;
logic MemReg;
logic WrEnable;
logic Reg2Loc;
logic IsImm;
logic AluSrc;
logic [2:0] ALUOp;
logic [1:0] ALURes;
logic UnCondBr;
logic BrTaken;
logic [1:0] FW_RegFile1, FW_RegFile2;

datapath_pipelined DATAPATH(
	.clk(clk),
	.reset(reset),
	// Control Signals
	.RegWrite_Ctrl(RegWrite),
	.MemReg_Ctrl(MemReg),
	.WrEnable_Ctrl(WrEnable),
	.RdEnable_Ctrl(RdEnable),
	.Reg2Loc_Ctrl(Reg2Loc),
	.IsImm_Ctrl(IsImm),
	.AluSrc_Ctrl(AluSrc),
	.ALUOp_Ctrl(ALUOp),
	.ALURes_Ctrl(ALURes),
	.UnCondBr_Ctrl(UnCondBr),
	.BrTaken_Ctrl(BrTaken),
	.FW_RegFile1_Ctrl(FW_RegFile1),
	.FW_RegFile2_Ctrl(FW_RegFile2),
	// Flags
	.ALUFlags({OVERFLOW_FROM_ALU, CARRYOUT_FROM_ALU, NEGATIVE_FROM_ALU, ZERO_FROM_ALU}),
	.IsRegRdZero(IsRegRdZero),
	// Current Instruction Under Execution
	.instruction_out(curr_instr),
	.instr_one_clock_before(instr_one_clock_before),
	.instr_two_clocks_before(instr_two_clocks_before)
);

control_unit_pipelined CONTROL_UNIT(
	.clk(clk),
	.reset(reset),
	.instruction(curr_instr),
	.instr_one_clock_before(instr_one_clock_before),
	.instr_two_clocks_before(instr_two_clocks_before),
	.alu_control_flags({OVERFLOW_FROM_ALU_FIN, CARRYOUT_FROM_ALU_FIN, NEGATIVE_FROM_ALU_FIN, ZERO_FROM_ALU_FIN}), // NOT USING OVERFLOW, CARRYOUT, NEGATIVE, ZERO TO SUPPORT B.LT (ACCELERATE BRANCHES)
	.IsRegRdZero(IsRegRdZero),
	.cpu_flag_registers_write_enb(flag_enable),
	.IsPreviousInstrSType(IsPreviousInstrSType),
	.control_signals({FW_RegFile1, FW_RegFile2, RegWrite, MemReg, WrEnable, RdEnable, Reg2Loc, IsImm, AluSrc, ALUOp, ALURes, UnCondBr, BrTaken})
);

mux_2x1_N #(.N(4)) EXTRACT_CONTROLS (
	{OVERFLOW_FROM_ALU_FIN, CARRYOUT_FROM_ALU_FIN, NEGATIVE_FROM_ALU_FIN, ZERO_FROM_ALU_FIN}, 
	IsPreviousInstrSType,
	{OVERFLOW_FROM_ALU, CARRYOUT_FROM_ALU, NEGATIVE_FROM_ALU, ZERO_FROM_ALU}, 
	{OVERFLOW, CARRYOUT, NEGATIVE, ZERO}
);


/*
	[1] {OVERFLOW_FROM_ALU, CARRYOUT_FROM_ALU, NEGATIVE_FROM_ALU, ZERO_FROM_ALU}: These are the flags that are sent from the ALU by the instruction fetched 1 clock before.
	[2] {OVERFLOW, CARRYOUT, NEGATIVE, ZERO}: These are the flags set by the last "S" Instruction executed on this CPU.
	
	Build a logic which can select [1] in case the previous Instruction is an "S" Instruction. If that's not the case, use [2].
*/

endmodule