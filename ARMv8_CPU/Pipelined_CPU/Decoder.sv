module Decoder(
input 			 RegWrite,
input 	[4:0]	 WriteRegister,
output	[31:0] DecodedBits);

wire [1:0] i_internal;

// Built using 1x2 and 1x16 demuxes
demux1x2  U1 (RegWrite, WriteRegister[4], i_internal);
demux1x16 U2 (i_internal[1], WriteRegister[3:0], DecodedBits[31:16]);
demux1x16 U3 (i_internal[0], WriteRegister[3:0], DecodedBits[15:0]);

endmodule