module mux32x1(y, s, i);
input [31:0] i;
input [4:0] s;
output y;

// Built using 16x1 and 2x1 muxes
mux16x1 U1 (x1, s[3:0], i[31:16]);
mux16x1 U2 (x2, s[3:0], i[15:0]);
mux2x1  U3 (y,  s[4], {x1, x2});

endmodule