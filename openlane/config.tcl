source $::env(CARAVEL_ROOT)/openlane/user_project_wrapper/fixed_wrapper_cfgs.tcl
set ::env(DESIGN_IS_CORE) 1
set ::env(SYNTH_STRATEGY) "AREA 0"
set ::env(FP_PDN_CORE_RING) 1
set ::env(FP_PDN_CHECK_NODES) 0
set ::env(CLOCK_PERIOD) 100
set ::env(CLOCK_PORT) "wb_clk_i"
set ::env(CLOCK_NET) "wb_clk_i"
set ::env(CLOCK_NETS_EVAL) "{get_full_name \[get_nets -of_objects ariel_fpga_top_inst.config_block_clk_buf.tech_clkbuf/X\]} {get_full_name \[get_nets -of_objects ariel_fpga_top_inst.config_vrnode_clk_buf.tech_clkbuf/X\]} {get_full_name \[get_nets -of_objects ariel_fpga_top_inst.config_hrnode_clk_buf.tech_clkbuf/X\]} "
set ::env(PL_MAX_DISPLACEMENT_X) 3000
set ::env(PL_MAX_DISPLACEMENT_Y) 1000
set ::env(FP_PDN_VOFFSET) 20
set ::env(FP_PDN_HOFFSET) 40
set ::env(FP_PDN_VPITCH) 64.5
set ::env(FP_PDN_HPITCH) 34.5
set ::env(FP_PDN_AUTO_ADJUST) 0
set ::env(FP_PDN_IRDROP) 0
set ::env(FP_PDN_CORE_RING_VOFFSET) 12.45
set ::env(FP_PDN_CORE_RING_HOFFSET) 12.45
set ::env(PL_TIME_DRIVEN) 1
set ::env(PL_TARGET_DENSITY) 0.45
set ::env(DIODE_INSERTION_STRATEGY) 3
set ::env(DECAP_CELL) sky130_fd_sc_hd__decap_4
set ::env(PL_RESIZER_MAX_WIRE_LENGTH) 2000.0
set ::env(PL_RESIZER_ALLOW_SETUP_VIOS) 1
set ::env(PL_RESIZER_HOLD_SLACK_MARGIN) 0.1
set ::env(PL_RESIZER_MAX_SLEW_MARGIN) 40
set ::env(GLB_RESIZER_MAX_SLEW_MARGIN) 40
set ::env(GLB_RESIZER_HOLD_SLACK_MARGIN) 0.1
set ::env(GLB_RESIZER_ALLOW_SETUP_VIOS) 1
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(GLB_RT_ALLOW_CONGESTION) 1
set ::env(GLB_RT_ADJUSTMENT) 0.1
set ::env(GLB_RT_LAYER_ADJUSTMENTS) 0.99,0.8,0.5,0.3,0,0
set ::env(FP_PDN_MACRO_HOOKS) ".*struct_block vccd1 vssd1"
set ::env(PDN_CFG) "/home/egor/proj/fpga/impl/open/pdn_cfg.tcl"
set ::env(RUN_KLAYOUT_XOR) 0
set ::env(VERILOG_FILES_BLACKBOX) "/home/egor/proj/fpga/impl/open/macros.v"
set ::env(EXTRA_LEFS) "/home/egor/proj/fpga/impl/open/best/fpga_struct_block/results/final/lef/fpga_struct_block.lef"
set ::env(EXTRA_GDS_FILES) "/home/egor/proj/fpga/impl/open/best/fpga_struct_block/results/final/gds/fpga_struct_block.gds"
set ::env(MACRO_PLACEMENT_CFG) "designs/user_project_wrapper/macro.cfg"
set ::env(DESIGN_NAME) user_project_wrapper
set ::env(VERILOG_FILES) "designs/user_project_wrapper/ariel_fpga_top_fromvhdl.v designs/user_project_wrapper/fpga_tech.v designs/user_project_wrapper/user_project_wrapper.v"
set ::env(BASE_SDC_FILE) "designs/user_project_wrapper/user_project_wrapper.sdc"
set ::env(FP_PIN_ORDER_CFG) "designs/user_project_wrapper/pin.cfg"
set ::env(SYNTH_DRIVING_CELL) "sky130_fd_sc_hd__buf_1"
set ::env(SYNTH_DRIVING_CELL_PIN) "X"
set ::env(ROUTING_CORES) 12

