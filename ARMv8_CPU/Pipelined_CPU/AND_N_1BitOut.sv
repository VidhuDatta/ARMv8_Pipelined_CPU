`timescale 1ns/10ps
module AND_N_1BitOut #(parameter num_input=64) (A, result);

input logic [num_input-1:0] A;
output logic result;

logic [15:0] stage1_res;
logic  [3:0] stage2_res;

genvar g1, g2;

generate
	for(g1 = 0; g1 < 16; g1=g1+1)
	begin: STAGE_1
		and #0.05 A0(stage1_res[g1], A[4*g1], A[4*g1+1], A[4*g1+2], A[4*g1+3]);
	end
endgenerate

generate
	for(g2 = 0; g2 < 4; g2=g2+1)
	begin: STAGE_2
		and #0.05 B0(stage2_res[g2], stage1_res[4*g2], stage1_res[4*g2+1], stage1_res[4*g2+2], stage1_res[4*g2+3]);
	end
endgenerate

and #0.05 C0(result, stage2_res[0], stage2_res[1], stage2_res[2], stage2_res[3]);

endmodule