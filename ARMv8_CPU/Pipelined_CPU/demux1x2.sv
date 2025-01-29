`timescale 1ns/10ps
module demux1x2(i, s, o);
input s;
input i;
output [1:0] o;

not #0.05 G1(sbar , s);
and #0.05 G2(o[0], sbar, i);
and #0.05 G3(o[1], s, i);

endmodule