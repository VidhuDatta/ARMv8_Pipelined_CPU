module mux_8x1(y, S, i7, i6, i5, i4, i3, i2, i1, i0);
input i7, i6, i5, i4, i3, i2, i1, i0;
input [2:0] S;
output y;

mux_4x1 U1 (x1, S[1:0], i7, i6, i5, i4);
mux_4x1 U2 (x2, S[1:0], i3, i2, i1, i0);
mux_2x1 U3 (y,  S[2], x1, x2);

endmodule