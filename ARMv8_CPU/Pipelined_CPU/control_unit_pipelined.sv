module control_unit_pipelined(
	input clk,
	input reset,
	input [31:0] instruction,
	input [31:0] instr_one_clock_before,
	input [31:0] instr_two_clocks_before,
	input [3:0] alu_control_flags,
	input IsRegRdZero, // NEEDED FOR CBZ INSTRUCTION
	output logic cpu_flag_registers_write_enb,
	output logic IsPreviousInstrSType, // To handle forwarding for conditional branches
	output logic [17:0] control_signals);

// alu_control_flags = {overflow, carry_out, negative, zero}
// control_signals   = {RegWrite_Ctrl, MemReg_Ctrl, WrEnable_Ctrl, Reg2Loc_Ctrl, IsImm_Ctrl, AluSrc_Ctrl, ALUOp_Ctrl, ALURes_Ctrl, UnCondBr_Ctrl, BrTaken_Ctrl, FW_RegFile1_Ctrl, FW_RegFile2_Ctrl}

/*
====================================================================================================================
Instr [OPCODE(31:26)] | RegWr | MemReg | Wr | Rd  | Reg2Loc | IsImm | AluSrc | ALUOp | ALURes | UnCondBr | BrTaken |
	  [OPCODE(25:21)] |       |        |          |         |       |        |       |        |          |         |
====================================================================================================================
ADDI	[100100]      |   1   |   0    | 0  |  0  |    x    |   1   |   0    |  010  |   00   |    x     |    0    |
		 [0100x]      |       |        |          |         |       |        |       |        |          |         |
ADDS	[101010]      |   1   |   0    | 0  |  0  |    1    |   0   |   0    |  010  |   00   |    x     |    0    |
		 [11000]      |       |        |          |         |       |        |       |        |          |         |
B 		[000101]      |   0   |   x    | 0  |  0  |    x    |   x   |   x    |  xxx  |   xx   |    1     |    1    |
	     [xxxxx]      |       |        |          |         |       |        |       |        |          |         |
B.LT	[010101]      |   0   |   x    | 0  |  0  |    x    |   x   |   x    |  xxx  |   xx   |    0     |f.neg != |
		 [00xxx]      |       |        |          |         |       |        |       |        |          |f.ov     |
CBZ 	[101101]      |   0   |   x    | 0  |  0  |    0    |   x   |   x    |  000  |   xx   |    0     |Reg[Rd]=0|
		 [00xxx]      |       |        |          |         |       |        |       |        |          |         |
LDUR	[111110]      |   1   |   1    | 0  |  1  |    x    |   0   |   1    |  010  |   00   |    x     |    0    |
		 [00010]      |       |        |          |         |       |        |       |        |          |         |
LSL		[110100]      |   1   |   0    | 0  |  0  |    x    |   x   |   x    |  xxx  |   01   |    x     |    0    |
		 [11011]      |       |        |          |         |       |        |       |        |          |         |
LSR		[110100]      |   1   |   0    | 0  |  0  |    x    |   x   |   x    |  xxx  |   10   |    x     |    0    |
		 [11010]      |       |        |          |         |       |        |       |        |          |         |
MUL		[100110]      |   1   |   0    | 0  |  0  |    1    |   x   |   x    |  xxx  |   11   |    x     |    0    |
		 [11000]      |       |        |          |         |       |        |       |        |          |         |
STUR	[111110]      |   0   |   x    | 1  |  0  |    0    |   0   |   1    |  010  |   00   |    x     |    0    |
		 [00000]      |       |        |          |         |       |        |       |        |          |         |
SUBS	[111010]      |   1   |   0    | 0  |  0  |    1    |   0   |   0    |  011  |   00   |    x     |    0    |
		 [11000]      |       |        |          |         |       |        |       |        |          |         |
====================================================================================================================
WHERE_USED            |   3   |   2    |    2     |    0    |   1   |   1    |   1   |    1   |    0     |    0    |

ADDITIONAL CHECKS FOR A FEW INSTRUCTIONS:
1)	B.LT: Also check instr[4:0] == 01011 (i.e., Cond Code = 0x0B)
2)	MUL : Also check instr[15:10] == 011111 (i.e., shamt = 1F)
*/

/* NOTE:
->	In the case of pipelined processor, the control signals need to be stored for more than 1 clock cycles based on where the control signal is being used.
*/

logic branch_taken, IsRdWritten, IsRdWritten_OneClk, IsRdWritten_TwoClk;
logic regWr_Clk0, regWr_Clk1, regWr_Clk2, regWr_Clk3, memReg_Clk0, memReg_Clk1, memReg_Clk2, Wr_Clk0, Wr_Clk1, Wr_Clk2, Rd_Clk0, Rd_Clk1, Rd_Clk2, IsImm_Clk0, IsImm_Clk1, AluSrc_Clk0, AluSrc_Clk1, cpu_flag_registers_write_enb0, cpu_flag_registers_write_enb1;
logic [1:0] AluRes_Clk1, AluRes_Clk0;
logic [2:0] AluOp_Clk1, AluOp_Clk0;
logic [13:0] control_signals_comb;
logic [4:0] dest_addr_one_clock_before, dest_addr_two_clocks_before;
logic [1:0] FW_RegFile1, FW_RegFile2;

assign dest_addr_one_clock_before  = instr_one_clock_before[4:0];
assign dest_addr_two_clocks_before = instr_two_clocks_before[4:0];

assign IsDestAddrX31_OneClk = dest_addr_one_clock_before == 5'd31;
assign IsDestAddrX31_TwoClk = dest_addr_two_clocks_before == 5'd31;

assign IsRn_DestAddr_OneClk_IType = (instruction[9:5] == dest_addr_one_clock_before) && IsRdWritten_OneClk;
assign IsRn_DestAddr_TwoClk_IType = (instruction[9:5] == dest_addr_two_clocks_before) && IsRdWritten_TwoClk;

assign IsRm_DestAddr_OneClk_RType = (instruction[20:16] == dest_addr_one_clock_before) && IsRdWritten_OneClk;
assign IsRm_DestAddr_TwoClk_RType = (instruction[20:16] == dest_addr_two_clocks_before) && IsRdWritten_TwoClk;

assign IsRd_DestAddr_OneClk_CBType = (instruction[4:0] == dest_addr_one_clock_before) && IsRdWritten_OneClk;
assign IsRd_DestAddr_TwoClk_CBType = (instruction[4:0] == dest_addr_two_clocks_before) && IsRdWritten_TwoClk;

assign IsPreviousInstrSType = (instr_one_clock_before[31:21] == 11'b10101011000) || (instr_one_clock_before[31:21] == 11'b11101011000);

// Control Unit
always_comb
begin
	// HANDLES ALL THE "ELSE" CONDITIONS & DEFAULT SCENARIO FOR THE "CASE" BLOCK
	control_signals_comb = 14'd0; // b0x00xxxxxxxxx0
	branch_taken = 1'b0;
	cpu_flag_registers_write_enb0 = 1'b0;
	FW_RegFile1 = 2'd0;
	FW_RegFile2 = 2'd0;
	IsRdWritten = 1'b1;
	
	// ReadData1 Path:
	if(IsRn_DestAddr_OneClk_IType && ~IsDestAddrX31_OneClk)
		FW_RegFile1 = 2'd2; // => ForwardingPath_FromALU Enabled
	else if(IsRn_DestAddr_TwoClk_IType && ~IsDestAddrX31_TwoClk)
		FW_RegFile1 = 2'd1; // => ForwardingPath_FromMEM Enabled

	case(instruction[31:26])
		6'b100100: 	begin // -> I TYPE
						if(instruction[25:22] == 4'b0100) // ADDI
							control_signals_comb = 14'b1000x1001000x0;
					end
		6'b101010:	begin // -> R TYPE
						if(instruction[25:21] == 5'b11000) // ADDS
						begin
							control_signals_comb = 14'b100010001000x0;
							cpu_flag_registers_write_enb0 = 1'b1;
							// ReadData2 Path:
							if(IsRm_DestAddr_OneClk_RType && ~IsDestAddrX31_OneClk)
								FW_RegFile2 = 2'd2; // => ForwardingPath_FromALU Enabled
							else if(IsRm_DestAddr_TwoClk_RType && ~IsDestAddrX31_TwoClk)
								FW_RegFile2 = 2'd1; // => ForwardingPath_FromMEM Enabled
						end
					end
		6'b000101:	control_signals_comb = 14'b0x00xxxxxxxx11; // B
		6'b010101:	begin // -> CB TYPE
						if(instruction[25:24] == 2'b00 & instruction[4:0] == 5'b01011) // B.LT
						begin
							branch_taken = (((alu_control_flags[3] == 1'b0) && (alu_control_flags[1] == 1'b1)) ||
								((alu_control_flags[3] == 1'b1) && (alu_control_flags[1] == 1'b0)));
							control_signals_comb = {13'b0x00xxxxxxxx0, branch_taken};
						end
					end
		6'b101101:	begin // -> CB TYPE
						if(instruction[25:24] == 2'b00) // CBZ
						begin
							branch_taken = IsRegRdZero;
							IsRdWritten  = 1'b0;
							control_signals_comb = {13'b0x000xx000xx0, branch_taken};
							if(IsRd_DestAddr_OneClk_CBType && ~IsDestAddrX31_OneClk)
								FW_RegFile2 = 2'd2; // => ForwardingPath_FromALU Enabled
							else if(IsRd_DestAddr_TwoClk_CBType && ~IsDestAddrX31_TwoClk)
								FW_RegFile2 = 2'd1; // => ForwardingPath_FromMEM Enabled
						end
					end
		6'b111110: 	begin // -> D TYPE
						if(instruction[25:21] == 5'b00010) // LDUR
							control_signals_comb = 14'b1101x0101000x0;
						else if(instruction[25:21] == 5'd0) // STUR
						begin
							control_signals_comb = 14'b0x1000101000x0;
							IsRdWritten  = 1'b0;
							if(IsRd_DestAddr_OneClk_CBType && ~IsDestAddrX31_OneClk)
								FW_RegFile2 = 2'd2; // => ForwardingPath_FromALU Enabled
							else if(IsRd_DestAddr_TwoClk_CBType && ~IsDestAddrX31_TwoClk)
								FW_RegFile2 = 2'd1; // => ForwardingPath_FromMEM Enabled
						end
					end
		6'b110100: 	begin // -> R TYPE
						if(instruction[25:21] == 5'b11011) // LSL
							control_signals_comb = 14'b1000xxxxxx01x0;
						else if(instruction[25:21] == 5'b11010) // LSR
							control_signals_comb = 14'b1000xxxxxx10x0;
						
						// ReadData2 Path:
						if(IsRm_DestAddr_OneClk_RType && ~IsDestAddrX31_OneClk)
							FW_RegFile2 = 2'd2; // => ForwardingPath_FromALU Enabled
						else if(IsRm_DestAddr_TwoClk_RType && ~IsDestAddrX31_TwoClk)
							FW_RegFile2 = 2'd1; // => ForwardingPath_FromMEM Enabled
					end
		6'b100110: 	begin // -> R TYPE
						if(instruction[25:21] == 5'b11000 && instruction[15:10] == 6'b011111) // MUL
						begin
							control_signals_comb = 14'b10001xxxxx11x0;
							// ReadData2 Path:
							if(IsRm_DestAddr_OneClk_RType && ~IsDestAddrX31_OneClk)
								FW_RegFile2 = 2'd2; // => ForwardingPath_FromALU Enabled
							else if(IsRm_DestAddr_TwoClk_RType && ~IsDestAddrX31_TwoClk)
								FW_RegFile2 = 2'd1; // => ForwardingPath_FromMEM Enabled
						end
					end
		6'b111010: 	begin // -> R TYPE
						if(instruction[25:21] == 5'b11000) // SUBS
						begin
							control_signals_comb = 14'b100010001100x0;
							cpu_flag_registers_write_enb0 = 1'b1;
							// ReadData2 Path:
							if(IsRm_DestAddr_OneClk_RType && ~IsDestAddrX31_OneClk)
								FW_RegFile2 = 2'd2; // => ForwardingPath_FromALU Enabled
							else if(IsRm_DestAddr_TwoClk_RType && ~IsDestAddrX31_TwoClk)
								FW_RegFile2 = 2'd1; // => ForwardingPath_FromMEM Enabled
						end
					end
	endcase
	AluOp_Clk0  = control_signals_comb[6:4];
	AluRes_Clk0 = control_signals_comb[3:2];
	regWr_Clk0 	= control_signals_comb[13];
	memReg_Clk0 = control_signals_comb[12];
	Wr_Clk0 	= control_signals_comb[11];
	Rd_Clk0 	= control_signals_comb[10];
	IsImm_Clk0 	= control_signals_comb[8];
	AluSrc_Clk0 = control_signals_comb[7];
end

// Preserve control signal information:

/////// Preserve for 1 Clock //////////
Register #(.WIDTH(3)) ALU_OP_PRESERVE_REG(
	.clk(clk),
	.reset(reset),
	.DataIn(AluOp_Clk0),
	.WriteEnable(1'b1),
	.DataOut(AluOp_Clk1)
	);

Register #(.WIDTH(2)) ALU_RES_PRESERVE_REG(
	.clk(clk),
	.reset(reset),
	.DataIn(AluRes_Clk0),
	.WriteEnable(1'b1),
	.DataOut(AluRes_Clk1)
	);

D_FF_Enable dff_IsImm1(IsImm_Clk0, 1'b1, clk, reset, IsImm_Clk1);
D_FF_Enable dff_AluSrc1(AluSrc_Clk0, 1'b1, clk, reset, AluSrc_Clk1);

/////// Preserve for 3 Clocks //////////
D_FF_Enable dff_Wr0(Wr_Clk0, 1'b1, clk, reset, Wr_Clk1);
D_FF_Enable dff_Wr1(Wr_Clk1, 1'b1, clk, reset, Wr_Clk2);

D_FF_Enable dff_Rd0(Rd_Clk0, 1'b1, clk, reset, Rd_Clk1);
D_FF_Enable dff_Rd1(Rd_Clk1, 1'b1, clk, reset, Rd_Clk2);

/////// Preserve for 4 Clock //////////
D_FF_Enable dff_RegWr0(regWr_Clk0, 1'b1, clk, reset, regWr_Clk1);
D_FF_Enable dff_RegWr1(regWr_Clk1, 1'b1, clk, reset, regWr_Clk2);
D_FF_Enable dff_RegWr2(regWr_Clk2, 1'b1, clk, reset, regWr_Clk3);

D_FF_Enable dff_MemReg0(memReg_Clk0, 1'b1, clk, reset, memReg_Clk1);
D_FF_Enable dff_MemReg1(memReg_Clk1, 1'b1, clk, reset, memReg_Clk2);

D_FF_Enable dff_FLAGREGENB(cpu_flag_registers_write_enb0, 1'b1, clk, reset, cpu_flag_registers_write_enb1);
assign cpu_flag_registers_write_enb = cpu_flag_registers_write_enb1;

///////// NOTE //////////////
/*
	If the instr before 1 or 2 clocks has the Rd same as Rn/ Rm of the current instruction, don't just blindly perform the forwarding.
	We also need to ensure that the Rd in those previous instructions are indeed updated by them.
	For ex:
		If those instructions were STUR (OR) CBZ, where the Rd are read and not written/ updated, don't perform the forwarding.
	Implementation:
		Store that information in registers called IsRdWritten_OneClk, IsRdWritten_TwoClk.
*/
D_FF_Enable dff_IsRD1(IsRdWritten, 1'b1, clk, reset, IsRdWritten_OneClk);
D_FF_Enable dff_IsRD2(IsRdWritten_OneClk, 1'b1, clk, reset, IsRdWritten_TwoClk);

// Final Control Signals
assign control_signals = {FW_RegFile1, FW_RegFile2, regWr_Clk3, memReg_Clk2, Wr_Clk2, Rd_Clk2, control_signals_comb[9], IsImm_Clk1, AluSrc_Clk1, AluOp_Clk1, AluRes_Clk1, control_signals_comb[1:0]};

endmodule