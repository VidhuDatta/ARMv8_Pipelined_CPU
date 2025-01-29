`timescale 1ns/10ps
module cpu_tb();

logic clk, reset;

always #100 clk = !clk;

cpu_pipelined CPU(
	.clk(clk),
	.reset(reset) // synchronous reset
);

initial begin
	clk = 1'b0;
	reset = 1'b1;
	// First reset so that the PC points to the 0th instruction when CPU starts off...
	repeat(1) @(posedge clk);
	#100;
	reset = 1'b0;
	// Run for long enough to execute all the instructions in the instruction memory
	#(100*2000);
	$finish;
end

endmodule