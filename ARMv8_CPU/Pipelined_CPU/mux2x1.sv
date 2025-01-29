`timescale 1ns/10ps
module mux2x1 (y, s, i);
input s;
input [1:0] i;
output y;

not #0.05 G1(sbar , s);
and #0.05 G2(p1, sbar, i[0]);
and #0.05 G3(p2, s, i[1]);
or  #0.05 G4(y, p1, p2);
endmodule