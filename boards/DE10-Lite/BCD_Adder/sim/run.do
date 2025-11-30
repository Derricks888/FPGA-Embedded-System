# =======================================
# ModelSim Simulation Script for BCD Adder
# =======================================

# Clean previous work library
if { [file exists work] } {
    vdel -all
}

vlib work
vmap work work

# Compile RTL
vcom -2008 ../rtl/FA.vhd
vcom -2008 ../rtl/C4M1P4.vhd

# Compile testbench
vcom -2008 tb_BCD_Adder.vhd

# Launch simulation
vsim work.tb_BCD_Adder

# Add waveforms
add wave -r *

# Run for 500 ns
run 500 ns
