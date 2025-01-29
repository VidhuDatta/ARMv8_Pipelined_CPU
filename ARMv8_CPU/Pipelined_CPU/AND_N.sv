`timescale 1ns/10ps
module AND_N #(parameter num_input = 64) (A, B, result, negative, zero);

input logic [num_input-1:0] A, B;
output logic [num_input-1:0] result;
output logic negative, zero;

genvar g_and;

generate
	for(g_and = 0; g_and < num_input; g_and=g_and+1)
	begin: VECTOR_AND
		and #0.05 A0(result[g_and], A[g_and], B[g_and]);
	end
endgenerate

assign negative = result[num_input-1];
comp_N_1BitOut CMP_BLK(result, 64'd0, zero);

endmodule