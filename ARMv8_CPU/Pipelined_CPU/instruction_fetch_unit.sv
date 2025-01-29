module instruction_fetch_unit(
	input clk,
	input reset,
	input [63:0] BranchAddress,
	// control signals
	input BrTaken_Ctrl,
	// pipeline registers
	output logic [95:0] INSTRUCTION_PIPELINE_REG
);

// internal signals
logic [63:0] PC_COMPUTE_ADDER1_OUT, PC_COMPUTE_ADDER2_OUT;

// PROGRAM COUNTER
logic 	[63:0] ProgramCounter, NextProgramCounter;

// INSTRUCTION MEMORY
logic 	[31:0] instr;

/*
	==========================================================
	================== PROGRAM COUNTER =======================
	==========================================================
*/

/*
	============== FEEDBACK PATH TO PROGRAM COUNTER [PART-1] ==========
*/
Adder_64 PC_COMPUTE_ADDER2(
	.a(ProgramCounter), // PROGRAM COUNTER
	.b(64'd4),
	.sum(PC_COMPUTE_ADDER2_OUT)
	);

assign PC_COMPUTE_ADDER1_OUT = BranchAddress;

mux_2x1_N BR_TAKEN_MUX(NextProgramCounter, BrTaken_Ctrl, PC_COMPUTE_ADDER1_OUT, PC_COMPUTE_ADDER2_OUT);

/*
	========== END OF FEEDBACK PATH TO PROGRAM COUNTER [PATH-1] =======
*/

// THINK/ FIX: HOW TO ENSURE THE PROGRAM COUNTER STARTS OFF WITH A VALUE=0?
// Leverage reset port
Register PC_REG(
	.clk(clk),
	.reset(reset),
	.DataIn(NextProgramCounter),
	.WriteEnable(1'b1),
	.DataOut(ProgramCounter) // Input to Instruction memory
	);

/*
	==========================================================
	================== INSTRUCTION MEMORY ====================
	==========================================================
*/
instructmem INSTR_FETCH(
	.address(ProgramCounter),
	.instruction(instr),
	.clk(clk)	// Memory is combinational, but used for error-checking
	);

///// IF REG /////
Register #(.WIDTH(96)) INSTR_P_REG(
	.clk(clk),
	.reset(reset),
	.DataIn({ProgramCounter, instr}),
	.WriteEnable(1'b1),
	.DataOut(INSTRUCTION_PIPELINE_REG) // OUTPUT INSTR FROM THE PIPELINE REGISTER
	);

endmodule