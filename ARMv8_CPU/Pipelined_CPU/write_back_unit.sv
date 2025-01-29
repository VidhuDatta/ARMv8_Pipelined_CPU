module write_back_unit(
	input clk,
	input reset,
	// pipeline registers
	input [223:0] MEM_PIPELINE_REG,
	output logic [63:0] REG_FILE_WriteData,
	output logic [4:0] REG_FILE_WriteRegister
);

// Internal Signals
logic [63:0] ALU_result, data_mem_read_data;
logic [31:0] instr_in_WB_unit;

// Unpack elements from the MEM_PIPELINE_REG
assign {ALU_result, data_mem_read_data, instr_in_WB_unit, REG_FILE_WriteData} = MEM_PIPELINE_REG;
assign REG_FILE_WriteRegister = instr_in_WB_unit[4:0];

endmodule