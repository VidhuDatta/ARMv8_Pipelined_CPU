`timescale 1ns/10ps
module Adder_Sub_64(
    input  [63:0] a,       // 64-bit input a
    input  [63:0] b,       // 64-bit input b
    input  Carryin,
    output [63:0] sum,    // 64-bit sum output
    output Carryout,       // Final carry output
    output Overflow,
    output Negative,
    output Zero
);
    
    wire [63:0] carry;         // Internal carries between each full adder

    // First Full Adder (LSB)
    Adder_Sub FA0 (
        .a(a[0]),
        .b(b[0]),
        .Carryin(Carryin),
		.add_sub_flag(Carryin),
        .sum(sum[0]),
        .Carryout(carry[0])
    );

    // Instantiate Full Adders for bits 1 to 63
    genvar i;
    generate
        for (i = 1; i < 64; i = i + 1) begin : adder_sub_loop
            Adder_Sub FA (
                .a(a[i]),
                .b(b[i]),
                .Carryin(carry[i-1]),
				.add_sub_flag(Carryin),
                  // Carry from the previous stage
                .sum(sum[i]),
                .Carryout(carry[i])
            );
        end
    endgenerate
   
	// Flags:
	// Carry out
	// special scenario to consider:
	/*
		While configuring this unit as a subtractor, the carry_out flag would be set to 1 (WHICH IS INCORRECT):
		A    = 00000000000..000
		B    = 00000000000..000
		~B   = 11111111111..111
		~B+1 =100000000000..000
		So, carry_out is actually equal to 1.
		But, arithmetically, there is no carry_out when you subtract 0 from 0. So, handle this scenario.
	*/
	// Is A == 0
	comp_N_1BitOut CMP_BLK_A(a, 64'd0, Is_A_zero);
	// Is B == 0
	comp_N_1BitOut CMP_BLK_B(b, 64'd0, Is_B_zero);
	// Are both A and B zeros & Is the operation subtract?
	and #0.05 AB_AND (Are_A_B_Zero_OP_SUB, Is_A_zero, Is_B_zero, Carryin);
	mux_2x1 M_CARRY(Carryout, Are_A_B_Zero_OP_SUB, 1'b0, carry[63]);
	
	// Overflow
	// special scenario to consider:
	/*
		While configuring this unit as a subtractor, the overflow flag would be set to 1 (WHICH IS INCORRECT):
		A    = 00000000000..000
		B    = 00000000000..000
		~B   = 11111111111..111
		~B+1 =100000000000..000
		So, overflow is actually equal to 1 because:
		Carry_in for 64th ALU is 1 & Carryout for the 64th ALU would be 0 (FIXED IN THE CARRYOUT SPECIAL SCENARIO AS DISCUSSED ABOVE)
		But, arithmetically, there is no overflow when you subtract 0 from 0. So, handle this scenario.
	*/
    xor #0.05 Ov (XOR_OUT, Carryout, carry[62]);
	mux_2x1 M_OVERFLOW(Overflow, Are_A_B_Zero_OP_SUB, 1'b0, XOR_OUT);

	// Zero
    comp_N_1BitOut CMP_BLK(sum, 64'd0, Zero);

	// Negative
    assign Negative = sum[63];
endmodule
