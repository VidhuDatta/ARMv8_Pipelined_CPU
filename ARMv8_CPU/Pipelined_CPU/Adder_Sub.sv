`timescale 1ns/10ps
module Adder_Sub (
    input a, b, Carryin, add_sub_flag,
    output sum, Carryout
);

xor #0.05 X (b_out, add_sub_flag, b);
Full_Adder FA (a, b_out, Carryin, sum, Carryout);

endmodule