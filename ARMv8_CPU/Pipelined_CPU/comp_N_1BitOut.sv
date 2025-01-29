module comp_N_1BitOut #(parameter num_input=64) (A, B, result_eq);
input [num_input-1:0] A, B;
output result_eq;

logic [num_input-1:0] bitwise_res;

genvar i;

generate
for(i=0; i<num_input; i=i+1)
begin: N_BIT_COMPARE
	comp1 BITCOMP(A[i], B[i], bitwise_res[i]);
end
endgenerate

AND_N_1BitOut O(bitwise_res, and_res);

assign result_eq = and_res;

endmodule