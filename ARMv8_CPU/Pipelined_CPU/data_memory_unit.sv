module data_memory_unit(
	input clk,
	input reset,
	// control signals
	input RdEnable_Ctrl,
	input WrEnable_Ctrl,
	input MemReg_Ctrl,
	// pipeline registers
	input [159:0] ALU_PIPELINE_REG,
	output logic [223:0] MEM_PIPELINE_REG,
	// Forwarding paths to RegFile
	output logic [63:0] ForwardingPath_To_REG,
	output logic [31:0] instr_in_dmem_unit
);

// DATA MEMORY INTERFACE SIGNALS
logic [63:0]	data_mem_address;
logic			data_mem_write_enable;
logic [63:0]	data_mem_write_data;
logic [63:0]	data_mem_read_data;

// other internal signals
logic [63:0] ALU_result, REG_FILE_ReadData2, PC_COMPUTE_ADDER1_OUT, REG_FILE_WriteData;

// Unpack elements from the ALU_PIPELINE_REG
assign {instr_in_dmem_unit, ALU_result, REG_FILE_ReadData2} = ALU_PIPELINE_REG;

/*
	==========================================================
	======================= DATAMEM ==========================
	==========================================================
*/
datamem DMEM(
	.address(data_mem_address),
	.write_enable(data_mem_write_enable),
	.read_enable(RdEnable_Ctrl),
	.write_data(data_mem_write_data),
	.clk(clk),
	.xfer_size(4'd8), // Always fetch 6 bytes of data from the data memory
	.read_data(data_mem_read_data)
	);

// Assign data_mem_write_enable to appropriate control Signal
assign data_mem_write_enable = WrEnable_Ctrl;
assign data_mem_address = ALU_result;
assign data_mem_write_data = REG_FILE_ReadData2;

// DMEM PIPELINE REGISTER
Register #(.WIDTH(224)) DMEM_P_REG(
	.clk(clk),
	.reset(reset),
	.DataIn({ALU_result, data_mem_read_data, instr_in_dmem_unit, REG_FILE_WriteData}),
	.WriteEnable(1'b1),
	.DataOut(MEM_PIPELINE_REG)
	);

/*
	============== PATH B/W REGFILE & DATAMEM ================
*/
// MemRegMux
mux_2x1_N MEMREG_MUX(REG_FILE_WriteData, MemReg_Ctrl, data_mem_read_data, ALU_result);
/*
	============ END OF PATH B/W REGFILE & DATAMEM ===========
*/
assign ForwardingPath_To_REG = REG_FILE_WriteData;

endmodule