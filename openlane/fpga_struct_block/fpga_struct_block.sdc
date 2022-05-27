create_clock -name "clk_i" -add -period 40 [get_ports clk_i]
create_clock -name "config_clk_i" -add -period 1000 [get_ports config_clk_i]

set_units -time 1ns

#set input_delay_value [expr $::env(CLOCK_PERIOD) * $::env(IO_PCT)]
#set output_delay_value [expr $::env(CLOCK_PERIOD) * $::env(IO_PCT)]
#puts "\[INFO\]: Setting output delay to: $output_delay_value"
#puts "\[INFO\]: Setting input delay to: $input_delay_value"

set_max_fanout $::env(SYNTH_MAX_FANOUT) [current_design]

if {[info exists CLOCK_PORT]} {
    set clk_indx [lsearch [all_inputs] [get_port $::env(CLOCK_PORT)]]
    #set rst_indx [lsearch [all_inputs] [get_port resetn]]
    set all_inputs_wo_clk [lreplace [all_inputs] $clk_indx $clk_indx]
    #set all_inputs_wo_clk_rst [lreplace $all_inputs_wo_clk $rst_indx $rst_indx]
    set all_inputs_wo_clk_rst $all_inputs_wo_clk
    puts "\[INFO\]: Setting clock uncertainity to: $::env(SYNTH_CLOCK_UNCERTAINITY)"
    set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINITY) [get_clocks $::env(CLOCK_PORT)]
}

# TODO set this as parameter
set_driving_cell -lib_cell $::env(SYNTH_DRIVING_CELL) -pin $::env(SYNTH_DRIVING_CELL_PIN) [all_inputs]
set cap_load [expr $::env(SYNTH_CAP_LOAD) / 1000.0]
puts "\[INFO\]: Setting load to: $cap_load"
set_load  $cap_load [all_outputs]

puts "\[INFO\]: Setting clock transition to: $::env(SYNTH_CLOCK_TRANSITION)"
#set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks $::env(CLOCK_PORT)]

puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 10}] %"
set_timing_derate -early [expr {1-$::env(SYNTH_TIMING_DERATE)}]
set_timing_derate -late [expr {1+$::env(SYNTH_TIMING_DERATE)}]


# Disable all cross-clocking paths
set_false_path -from [get_clocks clk_i] -to [get_clocks config_clk_i] 
set_false_path -from [get_clocks config_clk_i] -to [get_clocks clk_i] 

set BUFIPIN [lindex [lreverse [split [lindex [get_name [lindex [get_pin -hier *tech_buf/*] 0]] 0] /]] 0]
set BUFOPIN [lindex [lreverse [split [lindex [get_name [lindex [get_pin -hier *tech_buf/*] 1]] 0] /]] 0]

# Logic cell constraints
set_disable_timing [get_cells *logic_block*logic_cells***cell.lut.breaker*loop_breaker.tech_buf]

set_max_delay -ignore_clock_latency 0.7 -from [get_pins *logic_block*logic_cells*1*cell.in_bufs*1*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*1*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 0.7 -from [get_pins *logic_block*logic_cells*1*cell.in_bufs*2*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*1*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 1.4 -from [get_pins *logic_block*logic_cells*1*cell.in_bufs*3*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*1*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 1.4 -from [get_pins *logic_block*logic_cells*1*cell.in_bufs*4*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*1*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 0.22 -from [get_pins *logic_block*logic_cells*1*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*1*cell.cell_reg.register/D]
set_max_delay -ignore_clock_latency 0.7 -from [get_pins *logic_block*logic_cells*2*cell.in_bufs*1*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*2*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 0.7 -from [get_pins *logic_block*logic_cells*2*cell.in_bufs*2*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*2*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 1.4 -from [get_pins *logic_block*logic_cells*2*cell.in_bufs*3*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*2*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 1.4 -from [get_pins *logic_block*logic_cells*2*cell.in_bufs*4*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*2*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 0.22 -from [get_pins *logic_block*logic_cells*2*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*2*cell.cell_reg.register/D]
set_max_delay -ignore_clock_latency 0.7 -from [get_pins *logic_block*logic_cells*3*cell.in_bufs*1*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*3*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 0.7 -from [get_pins *logic_block*logic_cells*3*cell.in_bufs*2*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*3*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 1.4 -from [get_pins *logic_block*logic_cells*3*cell.in_bufs*3*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*3*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 1.4 -from [get_pins *logic_block*logic_cells*3*cell.in_bufs*4*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*3*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 0.22 -from [get_pins *logic_block*logic_cells*3*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*3*cell.cell_reg.register/D]
set_max_delay -ignore_clock_latency 0.7 -from [get_pins *logic_block*logic_cells*4*cell.in_bufs*1*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*4*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 0.7 -from [get_pins *logic_block*logic_cells*4*cell.in_bufs*2*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*4*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 1.4 -from [get_pins *logic_block*logic_cells*4*cell.in_bufs*3*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*4*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 1.4 -from [get_pins *logic_block*logic_cells*4*cell.in_bufs*4*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*4*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 0.22 -from [get_pins *logic_block*logic_cells*4*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*4*cell.cell_reg.register/D]
set_max_delay -ignore_clock_latency 0.7 -from [get_pins *logic_block*logic_cells*5*cell.in_bufs*1*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*5*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 0.7 -from [get_pins *logic_block*logic_cells*5*cell.in_bufs*2*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*5*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 1.4 -from [get_pins *logic_block*logic_cells*5*cell.in_bufs*3*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*5*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 1.4 -from [get_pins *logic_block*logic_cells*5*cell.in_bufs*4*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*5*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 0.22 -from [get_pins *logic_block*logic_cells*5*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*5*cell.cell_reg.register/D]
set_max_delay -ignore_clock_latency 0.7 -from [get_pins *logic_block*logic_cells*6*cell.in_bufs*1*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*6*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 0.7 -from [get_pins *logic_block*logic_cells*6*cell.in_bufs*2*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*6*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 1.4 -from [get_pins *logic_block*logic_cells*6*cell.in_bufs*3*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*6*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 1.4 -from [get_pins *logic_block*logic_cells*6*cell.in_bufs*4*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*6*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 0.22 -from [get_pins *logic_block*logic_cells*6*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*6*cell.cell_reg.register/D]
set_max_delay -ignore_clock_latency 0.7 -from [get_pins *logic_block*logic_cells*7*cell.in_bufs*1*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*7*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 0.7 -from [get_pins *logic_block*logic_cells*7*cell.in_bufs*2*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*7*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 1.4 -from [get_pins *logic_block*logic_cells*7*cell.in_bufs*3*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*7*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 1.4 -from [get_pins *logic_block*logic_cells*7*cell.in_bufs*4*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*7*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 0.22 -from [get_pins *logic_block*logic_cells*7*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*7*cell.cell_reg.register/D]
set_max_delay -ignore_clock_latency 0.7 -from [get_pins *logic_block*logic_cells*8*cell.in_bufs*1*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*8*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 0.7 -from [get_pins *logic_block*logic_cells*8*cell.in_bufs*2*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*8*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 1.4 -from [get_pins *logic_block*logic_cells*8*cell.in_bufs*3*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*8*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 1.4 -from [get_pins *logic_block*logic_cells*8*cell.in_bufs*4*cell_tstart.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*8*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN]
set_max_delay -ignore_clock_latency 0.22 -from [get_pins *logic_block*logic_cells*8*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells*8*cell.cell_reg.register/D]

# Crossbar constraints
set_max_delay -ignore_clock_latency 2.55 -from [get_pins *logic_block*logic_cells***cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN] -to [get_pins *logic_block*logic_cells***cell.in_bufs***cell_tstart.tech_buf/$BUFOPIN]
set_max_delay -ignore_clock_latency 2.55 -from [get_ports inputs_i*] -to [get_pins *logic_block*logic_cells***cell.in_bufs***cell_tstart.tech_buf/$BUFOPIN]

# Output constraints
set_max_delay -ignore_clock_latency 0.9 -from [get_pins *logic_block*logic_cells*1*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN] -to [get_ports outputs_o[0]]
set_max_delay -ignore_clock_latency 0.9 -from [get_pins *logic_block*logic_cells*1*cell.cell_reg.register/Q] -to [get_ports outputs_o[0]]
set_max_delay -ignore_clock_latency 0.9 -from [get_pins *logic_block*logic_cells*2*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN] -to [get_ports outputs_o[1]]
set_max_delay -ignore_clock_latency 0.9 -from [get_pins *logic_block*logic_cells*2*cell.cell_reg.register/Q] -to [get_ports outputs_o[1]]
set_max_delay -ignore_clock_latency 0.9 -from [get_pins *logic_block*logic_cells*3*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN] -to [get_ports outputs_o[2]]
set_max_delay -ignore_clock_latency 0.9 -from [get_pins *logic_block*logic_cells*3*cell.cell_reg.register/Q] -to [get_ports outputs_o[2]]
set_max_delay -ignore_clock_latency 0.9 -from [get_pins *logic_block*logic_cells*4*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN] -to [get_ports outputs_o[3]]
set_max_delay -ignore_clock_latency 0.9 -from [get_pins *logic_block*logic_cells*4*cell.cell_reg.register/Q] -to [get_ports outputs_o[3]]
set_max_delay -ignore_clock_latency 0.9 -from [get_pins *logic_block*logic_cells*5*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN] -to [get_ports outputs_o[4]]
set_max_delay -ignore_clock_latency 0.9 -from [get_pins *logic_block*logic_cells*5*cell.cell_reg.register/Q] -to [get_ports outputs_o[4]]
set_max_delay -ignore_clock_latency 0.9 -from [get_pins *logic_block*logic_cells*6*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN] -to [get_ports outputs_o[5]]
set_max_delay -ignore_clock_latency 0.9 -from [get_pins *logic_block*logic_cells*6*cell.cell_reg.register/Q] -to [get_ports outputs_o[5]]
set_max_delay -ignore_clock_latency 0.9 -from [get_pins *logic_block*logic_cells*7*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN] -to [get_ports outputs_o[6]]
set_max_delay -ignore_clock_latency 0.9 -from [get_pins *logic_block*logic_cells*7*cell.cell_reg.register/Q] -to [get_ports outputs_o[6]]
set_max_delay -ignore_clock_latency 0.9 -from [get_pins *logic_block*logic_cells*8*cell.lut.breaker*lut_tfinish.tech_buf/$BUFIPIN] -to [get_ports outputs_o[7]]
set_max_delay -ignore_clock_latency 0.9 -from [get_pins *logic_block*logic_cells*8*cell.cell_reg.register/Q] -to [get_ports outputs_o[7]]
set_input_delay 0.0  -clock [get_clocks config_clk_i] [get_ports config_shift_i]

