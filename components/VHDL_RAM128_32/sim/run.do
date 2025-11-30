# ===============================
# ModelSim Simulation Script
# For: VHDL_RAM128_32
# ===============================

# Clean previous work
if { [file exists work] } {
    vdel -all
}

# Create work library
vlib work
vmap work work

# Compile RTL
vcom -2008 ../rtl/ram128x32.vhd

# Compile testbench
vcom -2008 ../tb/tb_ram128x32.vhd

# Launch simulation
vsim work.tb_ram128x32

# Add all signals recursively to waveform
add wave -r *

# Run simulation for 500 ns
run 500 ns
