module demux1x4(i, s, o);
input  [1:0] s;
input 		 i;
output [3:0] o;

wire [1:0] i_internal;

// Built using 1x2 demuxes
demux1x2 U1 (i, s[1], i_internal);
demux1x2 U2 (i_internal[1], s[0], o[3:2]);
demux1x2 U3 (i_internal[0], s[0], o[1:0]);

endmodule