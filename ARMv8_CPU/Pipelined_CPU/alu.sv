module alu(A, B, cntrl, result, negative, zero, overflow, carry_out);

input logic	[63:0]	A, B;
input logic  [2:0] cntrl;
output logic [63:0] result;
output logic overflow, carry_out, negative, zero;

wire [63:0] ADD_SUB_OUT, BITWISE_AND_OUT, BITWISE_OR_OUT, BITWISE_XOR_OUT;

// 000:			result = B					value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

// Instantiate Adder/ Subtractor Block
Adder_Sub_64 as(
    .a(A),       			// 64-bit input a
    .b(B),       			// 64-bit input b
    .Carryin(cntrl[0]),
    .sum(ADD_SUB_OUT),    	// 64-bit sum output
    .Carryout(carry_out),   // Final carry output
    .Overflow(overflow),
    .Negative(NEGATIVE_ADD_SUB),
    .Zero(ZERO_ADD_SUB)
);

// Instantiate bitwise and
AND_N ba(
	.A(A), 
	.B(B), 
	.result(BITWISE_AND_OUT), 
	.negative(NEGATIVE_BITWISE_AND), 
	.zero(ZERO_BITWISE_AND));
	
// Instantiate bitwise or
OR_N bo(
	.A(A), 
	.B(B), 
	.result(BITWISE_OR_OUT), 
	.negative(NEGATIVE_BITWISE_OR), 
	.zero(ZERO_BITWISE_OR));

// Instantiate bitwise xor
XOR_N bx(
	.A(A), 
	.B(B), 
	.result(BITWISE_XOR_OUT), 
	.negative(NEGATIVE_BITWISE_XOR), 
	.zero(ZERO_BITWISE_XOR));

// Instantiate mux to connect result of ALU to one of the outputs from previous blocks based on the select signals
mux_8x1_N m_output(
	.y(result), 
	.S(cntrl), 
	.i7(64'dx), 
	.i6(BITWISE_XOR_OUT),
	.i5(BITWISE_OR_OUT), 
	.i4(BITWISE_AND_OUT), 
	.i3(ADD_SUB_OUT), 
	.i2(ADD_SUB_OUT), 
	.i1(64'dx), 
	.i0(B));

// Compute the zero flag for result = B case:
comp_N_1BitOut CMP_BLK(B, 64'd0, ZERO_B);
	
// Instantiate another mux to handle the flags
mux_8x1_N #(2) m_flags(
	.y({zero, negative}),
	.S(cntrl),
	.i7(2'dx),
	.i6({ZERO_BITWISE_XOR, NEGATIVE_BITWISE_XOR}),
	.i5({ZERO_BITWISE_OR, NEGATIVE_BITWISE_OR}),
	.i4({ZERO_BITWISE_AND, NEGATIVE_BITWISE_AND}),
	.i3({ZERO_ADD_SUB, NEGATIVE_ADD_SUB}),
	.i2({ZERO_ADD_SUB, NEGATIVE_ADD_SUB}),
	.i1(2'dx),
	.i0({ZERO_B, B[63]}));

endmodule