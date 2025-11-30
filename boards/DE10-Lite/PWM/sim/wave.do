add wave -divider "Clock and PWM"
add wave -radix binary sim:/tb_pwm/clk
add wave -radix unsigned sim:/tb_pwm/duty_cycle
add wave sim:/tb_pwm/pwm_out

add wave -divider "Internal DUT Signals"
add wave sim:/tb_pwm/dut/counter
