module mux_2x1_N #(parameter N = 64) (y, S, i1, i0);

input [N-1: 0] i1, i0;
input S;
output [N-1: 0] y;

genvar j;

generate
for(j=0; j <= N-1; j = j + 1)
begin: MULTIPLEX
	mux_2x1 Z (y[j], S, i1[j], i0[j]);
end
endgenerate

endmodule