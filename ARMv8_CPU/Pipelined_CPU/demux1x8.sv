module demux1x8(i, s, o);
input  [2:0] s;
input 		 i;
output [7:0] o;

wire [1:0] i_internal;

// Built using 1x2 and 1x4 demuxes
demux1x2 U1 (i, s[2], i_internal);
demux1x4 U2 (i_internal[1], s[1:0], o[7:4]);
demux1x4 U3 (i_internal[0], s[1:0], o[3:0]);

endmodule