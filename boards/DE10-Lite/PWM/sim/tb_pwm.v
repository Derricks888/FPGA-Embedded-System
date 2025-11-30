`timescale 1ns/1ps

module tb_pwm;

    reg clk = 0;
    reg [7:0] duty_cycle;
    wire pwm_out;

    // 50 MHz clock → 20 ns period
    always #10 clk = ~clk;

    // Instantiate DUT
    pwm_gen dut (
        .clk(clk),
        .duty_cycle(duty_cycle),
        .pwm_out(pwm_out)
    );

    initial begin
        // Initial value
        duty_cycle = 8'h00;
        #200000;   // 0% duty: LED off

        duty_cycle = 8'h40;
        #200000;   // 25% duty

        duty_cycle = 8'h80;
        #200000;   // 50% duty

        duty_cycle = 8'hC0;
        #200000;   // 75% duty

        duty_cycle = 8'hFF;
        #200000;   // 100% duty: LED fully on

        $stop;
    end

endmodule
