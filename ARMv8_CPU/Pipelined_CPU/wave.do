onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 31 {CPU SIGNALS}
add wave -noupdate /cpu_tb/CPU/clk
add wave -noupdate /cpu_tb/CPU/reset
add wave -noupdate -childformat {{{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[31]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[30]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[29]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[28]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[27]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[26]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[25]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[24]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[23]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[22]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[21]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[20]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[19]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[18]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[17]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[16]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[15]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[14]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[13]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[12]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[11]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[10]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[9]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[8]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[7]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[6]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[5]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[4]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[3]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[2]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[1]} -radix sfixed} {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[0]} -radix sfixed}} -expand -subitemconfig {{/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[31]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[30]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[29]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[28]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[27]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[26]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[25]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[24]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[23]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[22]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[21]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[20]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[19]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[18]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[17]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[16]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[15]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[14]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[13]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[12]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[11]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[10]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[9]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[8]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[7]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[6]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[5]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[4]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[3]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[2]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[1]} {-height 15 -radix sfixed} {/cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs[0]} {-height 15 -radix sfixed}} /cpu_tb/CPU/DATAPATH/RDU/REG_FILE/register_outputs
add wave -noupdate /cpu_tb/CPU/OVERFLOW
add wave -noupdate /cpu_tb/CPU/CARRYOUT
add wave -noupdate /cpu_tb/CPU/NEGATIVE
add wave -noupdate /cpu_tb/CPU/ZERO
add wave -noupdate -radix sfixed /cpu_tb/CPU/DATAPATH/IFU/ProgramCounter
add wave -noupdate -radix binary /cpu_tb/CPU/curr_instr
add wave -noupdate -divider -height 31 DEBUGGING
add wave -noupdate /cpu_tb/CPU/OVERFLOW_FROM_ALU
add wave -noupdate /cpu_tb/CPU/flag_enable
add wave -noupdate /cpu_tb/CPU/CARRYOUT_FROM_ALU
add wave -noupdate /cpu_tb/CPU/NEGATIVE_FROM_ALU
add wave -noupdate /cpu_tb/CPU/ZERO_FROM_ALU
add wave -noupdate /cpu_tb/CPU/RegWrite
add wave -noupdate /cpu_tb/CPU/MemReg
add wave -noupdate /cpu_tb/CPU/WrEnable
add wave -noupdate /cpu_tb/CPU/Reg2Loc
add wave -noupdate /cpu_tb/CPU/IsImm
add wave -noupdate /cpu_tb/CPU/AluSrc
add wave -noupdate /cpu_tb/CPU/ALUOp
add wave -noupdate /cpu_tb/CPU/ALURes
add wave -noupdate /cpu_tb/CPU/UnCondBr
add wave -noupdate /cpu_tb/CPU/BrTaken
add wave -noupdate /cpu_tb/CPU/FW_RegFile1
add wave -noupdate /cpu_tb/CPU/FW_RegFile2
add wave -noupdate /cpu_tb/CPU/RdEnable
add wave -noupdate /cpu_tb/CPU/IsRegRdZero
add wave -noupdate -divider -height 31 {DATAPATH SIGNALS}
add wave -noupdate /cpu_tb/CPU/DATAPATH/clk
add wave -noupdate /cpu_tb/CPU/DATAPATH/reset
add wave -noupdate /cpu_tb/CPU/DATAPATH/RegWrite_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/MemReg_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/WrEnable_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/RdEnable_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/Reg2Loc_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/IsImm_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/AluSrc_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/ALUOp_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/ALURes_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/UnCondBr_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/BrTaken_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/FW_RegFile1_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/FW_RegFile2_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/ALUFlags
add wave -noupdate /cpu_tb/CPU/DATAPATH/IsRegRdZero
add wave -noupdate -radix binary /cpu_tb/CPU/DATAPATH/instruction_out
add wave -noupdate /cpu_tb/CPU/DATAPATH/REG_FILE_WriteRegister
add wave -noupdate /cpu_tb/CPU/DATAPATH/REG_FILE_WriteData
add wave -noupdate /cpu_tb/CPU/DATAPATH/PC_COMPUTE_ADDER1_OUT
add wave -noupdate /cpu_tb/CPU/DATAPATH/ForwardingPath_FromMEM_ToReg
add wave -noupdate /cpu_tb/CPU/DATAPATH/ForwardingPath_FromALUToReg
add wave -noupdate /cpu_tb/CPU/DATAPATH/INSTRUCTION_PIPELINE_REG
add wave -noupdate /cpu_tb/CPU/DATAPATH/REGFILE_PIPELINE_REG
add wave -noupdate /cpu_tb/CPU/DATAPATH/ALU_PIPELINE_REG
add wave -noupdate /cpu_tb/CPU/DATAPATH/MEMORY_DATA_PIPELINE_REG
add wave -noupdate -divider -height 31 {INSTR FETCH SIGNALS}
add wave -noupdate /cpu_tb/CPU/DATAPATH/IFU/clk
add wave -noupdate /cpu_tb/CPU/DATAPATH/IFU/reset
add wave -noupdate /cpu_tb/CPU/DATAPATH/IFU/BranchAddress
add wave -noupdate /cpu_tb/CPU/DATAPATH/IFU/BrTaken_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/IFU/INSTRUCTION_PIPELINE_REG
add wave -noupdate /cpu_tb/CPU/DATAPATH/IFU/PC_COMPUTE_ADDER1_OUT
add wave -noupdate /cpu_tb/CPU/DATAPATH/IFU/PC_COMPUTE_ADDER2_OUT
add wave -noupdate /cpu_tb/CPU/DATAPATH/IFU/NextProgramCounter
add wave -noupdate -radix binary /cpu_tb/CPU/DATAPATH/IFU/instr
add wave -noupdate -divider -height 31 {REG DECODE SIGNALS}
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/clk
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/reset
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/RegWrite_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/Reg2Loc_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/FW_RegFile1_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/FW_RegFile2_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/REG_FILE_WriteData
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/ForwardingPath_FromMEM
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/ForwardingPath_FromALU
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/BRANCH_TARGET_ADDRESS
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/INSTRUCTION_PIPELINE_REG
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/REGFILE_PIPELINE_REG
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/UnCondBr_Ctrl
add wave -noupdate -radix unsigned /cpu_tb/CPU/DATAPATH/RDU/REG_FILE_ReadRegister1
add wave -noupdate -radix unsigned /cpu_tb/CPU/DATAPATH/RDU/REG_FILE_ReadRegister2
add wave -noupdate -radix unsigned /cpu_tb/CPU/DATAPATH/RDU/REG_FILE_WriteRegister
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/REG_FILE_ReadData1
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/REG_FILE_ReadData1_AfterFW
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/REG_FILE_ReadData2
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/REG_FILE_ReadData2_AfterFW
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/PC_Reg_Dec_Unit
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/UNCOND_BR_MUX_OUT
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/BR_SHIFT_OUT
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/PC_COMPUTE_ADDER1_OUT
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/SE_IMM26
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/SE_IMM19
add wave -noupdate /cpu_tb/CPU/DATAPATH/RDU/IsRegRdZero
add wave -noupdate -divider -height 31 {CONTROL SIGNALS}
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/clk
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/reset
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/instruction
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/alu_control_flags
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/IsRegRdZero
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/cpu_flag_registers_write_enb
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/control_signals
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/branch_taken
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/regWr_Clk0
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/regWr_Clk1
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/regWr_Clk2
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/regWr_Clk3
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/memReg_Clk0
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/memReg_Clk1
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/memReg_Clk2
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/Wr_Clk0
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/Wr_Clk1
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/Wr_Clk2
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/Rd_Clk0
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/Rd_Clk1
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/Rd_Clk2
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/IsImm_Clk0
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/IsImm_Clk1
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/AluSrc_Clk0
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/AluSrc_Clk1
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/AluRes_Clk1
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/AluRes_Clk0
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/AluOp_Clk1
add wave -noupdate /cpu_tb/CPU/CONTROL_UNIT/AluOp_Clk0
add wave -noupdate -radix binary -childformat {{{/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[13]} -radix binary} {{/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[12]} -radix binary} {{/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[11]} -radix binary} {{/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[10]} -radix binary} {{/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[9]} -radix binary} {{/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[8]} -radix binary} {{/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[7]} -radix binary} {{/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[6]} -radix binary} {{/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[5]} -radix binary} {{/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[4]} -radix binary} {{/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[3]} -radix binary} {{/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[2]} -radix binary} {{/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[1]} -radix binary} {{/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[0]} -radix binary}} -subitemconfig {{/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[13]} {-height 15 -radix binary} {/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[12]} {-height 15 -radix binary} {/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[11]} {-height 15 -radix binary} {/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[10]} {-height 15 -radix binary} {/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[9]} {-height 15 -radix binary} {/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[8]} {-height 15 -radix binary} {/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[7]} {-height 15 -radix binary} {/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[6]} {-height 15 -radix binary} {/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[5]} {-height 15 -radix binary} {/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[4]} {-height 15 -radix binary} {/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[3]} {-height 15 -radix binary} {/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[2]} {-height 15 -radix binary} {/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[1]} {-height 15 -radix binary} {/cpu_tb/CPU/CONTROL_UNIT/control_signals_comb[0]} {-height 15 -radix binary}} /cpu_tb/CPU/CONTROL_UNIT/control_signals_comb
add wave -noupdate -divider -height 31 {ALU SIGNALS}
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/clk
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/reset
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/AluSrc_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/ALURes_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/ALUOp_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/IsImm_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/REGFILE_PIPELINE_REG
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/ALU_PIPELINE_REG
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/ALUFlags
add wave -noupdate -radix sfixed /cpu_tb/CPU/DATAPATH/AL_UNIT/ForwardingPath_To_REG
add wave -noupdate -radix sfixed /cpu_tb/CPU/DATAPATH/AL_UNIT/ALU_A
add wave -noupdate -radix sfixed /cpu_tb/CPU/DATAPATH/AL_UNIT/ALU_B
add wave -noupdate -radix sfixed /cpu_tb/CPU/DATAPATH/AL_UNIT/ALU_result
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/ADD_SUB_RESULT
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/ALU_overflow
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/ALU_carry_out
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/ALU_negative
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/ALU_zero
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/ZE_IMM12
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/SE_DADDR9
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/IS_IMM_MUX_OUT
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/REG_FILE_ReadData2
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/REG_FILE_ReadData1
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/MUL_IN_Rn
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/MUL_IN_Rm
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/SHIFTER_OUT
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/SHIFTER_Rn
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/MUL_OUT_Rd
add wave -noupdate -radix binary /cpu_tb/CPU/DATAPATH/AL_UNIT/instr_in_exec_unit
add wave -noupdate /cpu_tb/CPU/DATAPATH/AL_UNIT/SHIFT_DIR
add wave -noupdate -divider -height 31 {MEM STAGE SIGNALS}
add wave -noupdate /cpu_tb/CPU/DATAPATH/DMU/clk
add wave -noupdate /cpu_tb/CPU/DATAPATH/DMU/reset
add wave -noupdate /cpu_tb/CPU/DATAPATH/DMU/RdEnable_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/DMU/WrEnable_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/DMU/MemReg_Ctrl
add wave -noupdate /cpu_tb/CPU/DATAPATH/DMU/ALU_PIPELINE_REG
add wave -noupdate /cpu_tb/CPU/DATAPATH/DMU/MEM_PIPELINE_REG
add wave -noupdate /cpu_tb/CPU/DATAPATH/DMU/ForwardingPath_To_REG
add wave -noupdate /cpu_tb/CPU/DATAPATH/DMU/data_mem_address
add wave -noupdate /cpu_tb/CPU/DATAPATH/DMU/data_mem_write_enable
add wave -noupdate /cpu_tb/CPU/DATAPATH/DMU/data_mem_write_data
add wave -noupdate /cpu_tb/CPU/DATAPATH/DMU/data_mem_read_data
add wave -noupdate /cpu_tb/CPU/DATAPATH/DMU/ALU_result
add wave -noupdate /cpu_tb/CPU/DATAPATH/DMU/REG_FILE_ReadData2
add wave -noupdate /cpu_tb/CPU/DATAPATH/DMU/PC_COMPUTE_ADDER1_OUT
add wave -noupdate /cpu_tb/CPU/DATAPATH/DMU/instr_in_dmem_unit
add wave -noupdate -divider -height 31 {WriteBack SIGNALS}
add wave -noupdate /cpu_tb/CPU/DATAPATH/WBU/clk
add wave -noupdate /cpu_tb/CPU/DATAPATH/WBU/reset
add wave -noupdate /cpu_tb/CPU/DATAPATH/WBU/MEM_PIPELINE_REG
add wave -noupdate /cpu_tb/CPU/DATAPATH/WBU/REG_FILE_WriteData
add wave -noupdate /cpu_tb/CPU/DATAPATH/WBU/ALU_result
add wave -noupdate /cpu_tb/CPU/DATAPATH/WBU/data_mem_read_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9500000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 218
configure wave -valuecolwidth 102
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {8074370 ps} {10725630 ps}
