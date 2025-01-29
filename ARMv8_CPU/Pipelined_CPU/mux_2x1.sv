`timescale 1ns/10ps
module mux_2x1 (y, s, i1, i0);
input s;
input i1, i0;
output y;

not #0.05 G1(sbar , s);
and #0.05 G2(p1, sbar, i0);
and #0.05 G3(p2, s, i1);
or  #0.05 G4(y, p1, p2);
endmodule
