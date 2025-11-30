# ====================================================
# TCL Script for CLI Simulation of BCD Adder
# ====================================================

vlib work
vmap work work

# Compile RTL
vcom -2008 ../rtl/FA.vhd
vcom -2008 ../rtl/C4M1P4.vhd

# Compile Testbench
vcom -2008 tb_BCD_Adder.vhd

# Simulate without GUI
vsim -c tb_BCD_Adder -do "run -all; quit"
