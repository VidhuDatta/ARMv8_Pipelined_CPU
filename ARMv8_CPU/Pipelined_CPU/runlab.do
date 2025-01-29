vlib work

#####################
#### LAB-1 FILES ####
#####################
vlog regfile.sv -sv +acc
vlog Decoder.sv -sv +acc
vlog D_FF.sv -sv +acc
vlog Register.sv -sv +acc
vlog D_FF_Enable.sv -sv +acc
vlog mux2x1.sv -sv +acc
vlog mux4x1.sv -sv +acc
vlog mux8x1.sv -sv +acc
vlog mux16x1.sv -sv +acc
vlog mux32x1.sv -sv +acc
vlog mux32x1_N.sv -sv +acc
vlog demux1x2.sv -sv +acc
vlog demux1x4.sv -sv +acc
vlog demux1x8.sv -sv +acc
vlog demux1x16.sv -sv +acc

#####################
#### LAB-2 FILES ####
#####################
vlog alu.sv -sv +acc
vlog AND_N.sv -sv +acc
vlog OR_N.sv -sv +acc
vlog XOR_N.sv -sv +acc
vlog comp1.sv -sv +acc
vlog comp_N_1BitOut.sv -sv +acc
vlog AND_N_1BitOut.sv -sv +acc
vlog mux_2x1.sv -sv +acc
vlog mux_4x1.sv -sv +acc
vlog mux_8x1.sv -sv +acc
vlog mux_8x1_N.sv -sv +acc
vlog Adder_Sub.sv -sv +acc
vlog Adder_Sub_64.sv -sv +acc
vlog Full_Adder.sv -sv +acc

#####################
#### LAB-4 FILES ####
#####################
vlog cpu_tb.sv -sv +acc
vlog instructmem.sv -sv +acc
vlog Adder_64.sv -sv +acc
vlog mux_2x1_N.sv -sv +acc
vlog mux_4x1_N.sv -sv +acc
vlog sign_extend.sv -sv +acc
vlog zero_extend.sv -sv +acc
vlog datamem.sv -sv +acc
vlog math.sv -sv +acc
vlog control_unit_pipelined.sv -sv +acc
vlog datapath_pipelined.sv -sv +acc
vlog instruction_fetch_unit.sv -sv +acc
vlog register_decode_unit.sv -sv +acc
vlog arithmetic_logic_unit.sv -sv +acc
vlog data_memory_unit.sv -sv +acc
vlog write_back_unit.sv -sv +acc
vlog cpu_pipelined.sv -sv +acc

vsim work.cpu_tb

# setup the wave window in the ModelSim
do wave.do

run -all