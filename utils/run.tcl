yosys read_verilog pwm.v
yosys read_verilog pwm_control.v
yosys synth_ecp5 -json ./build/out.json -abc9