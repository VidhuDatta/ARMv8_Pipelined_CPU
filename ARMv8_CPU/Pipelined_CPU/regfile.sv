module regfile(
input		   clk,
input 	[4:0]  ReadRegister1,
input 	[4:0]  ReadRegister2,
input 	[4:0]  WriteRegister,
input 	[63:0] WriteData,
input		   RegWrite,
output 	[63:0] ReadData1,
output 	[63:0] ReadData2);

wire [31:0] decoder_outputs;
wire [31:0] [63:0] register_outputs;

assign register_outputs[31] = 64'd0;

// Register file:
// Connect the decoder, register blocks, and the multiplexers as per the given design

Decoder dBlk(
	.RegWrite(RegWrite),
	.WriteRegister(WriteRegister),
	.DecodedBits(decoder_outputs));
	
genvar nRegs, nMux1, nMuxBits, nMux2;

generate
for(nRegs=0; nRegs<=30; nRegs=nRegs+1)
begin: REGINST
	Register rBlk(
		.clk(clk),
		.reset(1'b0), // regfile doesn't have a reset port.
		.DataIn(WriteData),
		.WriteEnable(decoder_outputs[nRegs]),
		.DataOut(register_outputs[nRegs]));
end

endgenerate

mux32x1_N MUX1(
	.i(register_outputs),
	.s(ReadRegister1),
	.y(ReadData1));

mux32x1_N MUX2(
	.i(register_outputs),
	.s(ReadRegister2),
	.y(ReadData2));

endmodule