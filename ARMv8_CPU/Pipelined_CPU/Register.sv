module Register #(parameter WIDTH=64)
(
input	 				 clk,
input					 reset,
input  [WIDTH-1:0] DataIn, 
input					 WriteEnable,
output [WIDTH-1:0] DataOut);

genvar n;

// Leverage D_FF_Enable to create a register element
generate
	for(n=0; n<WIDTH; n++)
	begin : RegDesign
		D_FF_Enable dff(DataIn[n], WriteEnable, clk, reset, DataOut[n]);
	end
endgenerate

endmodule