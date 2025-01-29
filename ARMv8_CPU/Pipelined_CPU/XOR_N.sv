`timescale 1ns/10ps
module XOR_N #(parameter num_input=64) (A, B, result, negative, zero);

input logic [num_input-1:0] A, B;
output logic [num_input-1:0] result;
output logic negative, zero;

genvar g_xor;

generate
	for(g_xor = 0; g_xor < num_input; g_xor=g_xor+1)
	begin: VECTOR_XOR
		xor #0.05 A0(result[g_xor], A[g_xor], B[g_xor]);
	end
endgenerate

assign negative = result[num_input-1];
comp_N_1BitOut CMP_BLK(result, 64'd0, zero);

endmodule