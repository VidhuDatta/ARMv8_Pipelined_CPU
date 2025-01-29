module mux_4x1(y, S, i3, i2, i1, i0);
input i3, i2, i1, i0;
input [1:0] S;
output y;

mux_2x1 U1 (x1, S[0], i3, i2);
mux_2x1 U2 (x2, S[0], i1, i0);
mux_2x1 U3 (y,  S[1], x1, x2);

endmodule