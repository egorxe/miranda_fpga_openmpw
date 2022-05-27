set ::env(DESIGN_IS_CORE) 0
set ::env(SYNTH_STRATEGY) "AREA 3"
set ::env(CLOCK_PERIOD) 100
set ::env(CLOCK_PORT) "clk_i config_clk_i"
set ::env(FP_CORE_UTIL) 59
set ::env(PL_TARGET_DENSITY) 0.7
set ::env(SYNTH_TIMING_DERATE) 0.07
set ::env(PL_TIME_DRIVEN) 1
set ::env(PL_ROUTABILITY_DRIVEN) 1
set ::env(RT_MAX_LAYER) met4
set ::env(VDD_NETS) [list {vccd1}]
set ::env(GND_NETS) [list {vssd1}]
set ::env(FP_PDN_VPITCH) 50
set ::env(FP_PDN_AUTO_ADJUST) 0
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(GLB_RT_ALLOW_CONGESTION) 1
set ::env(DIODE_INSERTION_STRATEGY) 3
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_HOLD_SLACK_MARGIN) 0.1
set ::env(PL_RESIZER_BUFFER_INPUT_PORTS) 0
set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 1
set ::env(GLB_RESIZER_HOLD_SLACK_MARGIN) 0.1
set ::env(GLB_RT_ADJUSTMENT) 0.3
set ::env(GLB_RT_LAYER_ADJUSTMENTS) 0.99,0.9,0.7,0,0,0
set ::env(RIGHT_MARGIN_MULT) 2
set ::env(LEFT_MARGIN_MULT) 2
set ::env(TOP_MARGIN_MULT) 2
set ::env(BOTTOM_MARGIN_MULT) 2
set ::env(DESIGN_NAME) fpga_struct_block
set ::env(VERILOG_FILES) "designs/fpga_struct_block/fpga_struct_block_fromvhdl.v designs/fpga_struct_block/fpga_tech.v"
set ::env(BASE_SDC_FILE) "designs/fpga_struct_block/fpga_struct_block.sdc"
set ::env(FP_PIN_ORDER_CFG) "designs/fpga_struct_block/pin.cfg"
set ::env(SYNTH_DRIVING_CELL) "sky130_fd_sc_hd__buf_1"
set ::env(SYNTH_DRIVING_CELL_PIN) "X"
set ::env(ROUTING_CORES) 12

