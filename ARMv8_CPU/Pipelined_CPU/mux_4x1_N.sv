module mux_4x1_N #(parameter N = 64) (y, S, i3, i2, i1, i0);

input [N-1: 0] i3, i2, i1, i0;
input [1:0] S;
output [N-1: 0] y;

genvar j;

generate
for(j=0; j <= N-1; j = j + 1)
begin: MULTIPLEX
	mux_4x1 Z (y[j], S, i3[j], i2[j], i1[j], i0[j]);
end
endgenerate

endmodule