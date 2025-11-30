# TCL simulation script for VHDL_RAM128_32

vlib work
vmap work work

# Compile sources
vcom -2008 ../rtl/ram128x32.vhd
vcom -2008 ../tb/tb_ram128x32.vhd

vsim tb_ram128x32

# Add signals
add wave -r *

# Run
run -all
