module PWM_Control #(
    parameter CLK_FREQ = 25_000_000,
    parameter PWM_FREQ = 1_250
) (
    input  wire clk,
    input  wire rst_n,
    output wire [7:0] leds
);
    localparam integer PWM_CLK_PERIOD = CLK_FREQ / PWM_FREQ;
    localparam integer PWM_DUTY_CYCLE = 50; // 0.0025% duty cycle

    localparam SECOND         = CLK_FREQ;
    localparam HALF_SECOND    = SECOND / 2;
    localparam QUARTER_SECOND = SECOND / 4;
    localparam EIGHTH_SECOND  = SECOND / 8;

endmodule