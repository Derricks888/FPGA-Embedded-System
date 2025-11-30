# ==========================================================
# ModelSim Simulation Script for BCD Adder
# ==========================================================

# Clean previous work library
if { [file exists work] } {
    vdel -all
}

# Create and map work library
vlib work
vmap work work

# Compile RTL
vcom -2008 ../rtl/FA.vhd
vcom -2008 ../rtl/C4M1P4.vhd

# Compile testbench
vcom -2008 tb_BCD_Adder.vhd

# Start simulation
vsim work.tb_BCD_Adder

# Add all signals to waveform
do wave.do

# Run simulation
run -all
