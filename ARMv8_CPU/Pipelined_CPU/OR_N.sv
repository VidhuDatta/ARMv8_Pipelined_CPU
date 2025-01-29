`timescale 1ns/10ps
module OR_N #(parameter num_input = 64) (A, B, result, negative, zero);

input logic [num_input-1:0] A, B;
output logic [num_input-1:0] result;
output logic negative, zero;

genvar g_or;

generate
	for(g_or = 0; g_or < num_input; g_or=g_or+1)
	begin: VECTOR_OR
		or #0.05 A0(result[g_or], A[g_or], B[g_or]);
	end
endgenerate

assign negative = result[num_input-1];
comp_N_1BitOut CMP_BLK(result, 64'd0, zero);

endmodule