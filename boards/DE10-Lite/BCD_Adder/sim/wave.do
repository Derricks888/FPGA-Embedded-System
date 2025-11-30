# =============================================
# Waveform Setup for BCD Adder Testbench
# =============================================

add wave -divider "Inputs"
add wave -radix unsigned sim:/tb_BCD_Adder/A
add wave -radix unsigned sim:/tb_BCD_Adder/B

add wave -divider "Outputs"
add wave -radix unsigned sim:/tb_BCD_Adder/sum
add wave -radix unsigned sim:/tb_BCD_Adder/carry_out

add wave -divider "Internal Signals"
add wave -r sim:/tb_BCD_Adder/dut/*

configure wave -signalnamewidth 2
configure wave -namecolwidth 200
configure wave -valuecolwidth 120
