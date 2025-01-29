module mux8x1(y, s, i);
input [7:0] i;
input [2:0] s;
output y;

// Built using 2x1 and 4x1 muxes
mux4x1 U1 (x1, s[1:0], i[7:4]);
mux4x1 U2 (x2, s[1:0], i[3:0]);
mux2x1 U3 (y,  s[2], {x1, x2});

endmodule