vlib work
vlog ../rtl/pwm_gen.v
vlog ../rtl/debouncer.v
vlog ../rtl/pwm_led_top.v
vlog tb_pwm.v

vsim work.tb_pwm
do wave.do
run 2 ms
