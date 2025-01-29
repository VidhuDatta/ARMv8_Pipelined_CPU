module mux32x1_N #(parameter NumOfMuxes = 64)
(y, s, i);

input  [31:0][NumOfMuxes-1:0] 	i;
input  [4:0] 					s;
output [NumOfMuxes-1:0]			y;

genvar x, t;

// vectored 32x1 mux:
// ->	The mux has 32 input lines and 1 output line with 5 bit select signal.
// ->	Each input line and the output line has 64-bits and hence making this module a vectored mux.
generate
	for(x=0; x <= NumOfMuxes-1; x = x+1)
	begin: MUXBLOCKS
		wire [31:0] temp;

		for(t=0; t<=31; t=t+1)
		begin: BITEXTRACT
			assign temp[t] = i[t][x];
		end

		mux32x1 U (.y(y[x]), 
		.s(s), 
		.i(temp));
	end
endgenerate

endmodule