module mux16x1(y, s, i);
input [15:0] i;
input [3:0] s;
output y;

// Built using 8x1 and 2x1 muxes
mux8x1 U1 (x1, s[2:0], i[15:8]);
mux8x1 U2 (x2, s[2:0], i[7:0]);
mux2x1 U3 (y,  s[3], {x1, x2});

endmodule