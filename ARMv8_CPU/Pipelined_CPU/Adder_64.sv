module Adder_64(
    input  [63:0] a,      // 64-bit input a
    input  [63:0] b,      // 64-bit input b
    output [63:0] sum     // 64-bit sum output
);

	wire [63:0] carry;         // Internal carries between each full adder

    // First Full Adder (LSB)
    Full_Adder FA0 (
        .a(a[0]),
        .b(b[0]),
        .Carryin(1'b0),
        .sum(sum[0]),
        .Carryout(carry[0])
    );
	
	// Instantiate Full Adders for bits 1 to 63
    genvar i;
    generate
        for (i = 1; i < 64; i = i + 1) begin : adder_sub_loop
            Full_Adder FA (
                .a(a[i]),
                .b(b[i]),
                .Carryin(carry[i-1]),
                .sum(sum[i]),
                .Carryout(carry[i])
            );
        end
    endgenerate
endmodule