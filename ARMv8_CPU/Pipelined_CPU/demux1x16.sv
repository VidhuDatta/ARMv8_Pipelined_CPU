module demux1x16(i, s, o);
input  [3:0]  s;
input 		  i;
output [15:0] o;

wire [1:0] i_internal;

// Built using 1x2 and 1x8 demuxes
demux1x2 U1 (i, s[3], i_internal);
demux1x8 U2 (i_internal[1], s[2:0], o[15:8]);
demux1x8 U3 (i_internal[0], s[2:0], o[7:0]);

endmodule