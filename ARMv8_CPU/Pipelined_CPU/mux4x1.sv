module mux4x1(y, s, i);
input [3:0] i;
input [1:0] s;
output y;

// Built using 2x1 muxes
mux2x1 U1 (x1, s[0], i[3:2]);
mux2x1 U2 (x2, s[0], i[1:0]);
mux2x1 U3 (y,  s[1], {x1, x2});

endmodule