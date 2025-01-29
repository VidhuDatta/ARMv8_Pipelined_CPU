module sign_extend #(parameter INPUT_BIT_WIDTH=9) (
	input [INPUT_BIT_WIDTH-1:0] inp, 
	output logic [63:0] outp);

genvar g;

assign outp[INPUT_BIT_WIDTH-1:0] = inp;

generate
for(g=INPUT_BIT_WIDTH; g <= 63; g=g+1)
begin: WIRE_SE
	assign outp[g] = inp[INPUT_BIT_WIDTH-1];
end
endgenerate

endmodule