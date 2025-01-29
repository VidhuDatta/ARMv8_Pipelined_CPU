`timescale 1ns/10ps
module comp1 (A, B, result_eq);
/* USED TO COMPARE ONLY IF A and B are both 0 */
input A, B;
output result_eq;

nor #0.05 G (result_eq, A, B);

endmodule