module PWM_Control #(
    parameter CLK_FREQ = 25_000_000,
    parameter PWM_FREQ = 1_250
) (
    input  wire clk,
    input  wire rst_n,
    output wire [7:0] leds
);
    localparam [15:0] PWM_CLK_PERIOD = CLK_FREQ / PWM_FREQ; // 20000
    localparam integer DUTY_CYCLE_MIN = PWM_CLK_PERIOD * 25 / 1_000_000; // 0.0025% de 20000 => 0.5 ≈ 1
    localparam integer DUTY_CYCLE_MAX = PWM_CLK_PERIOD * 70 / 100; // 70% de 20000 => 14000

    localparam SECOND         = CLK_FREQ;
    localparam HALF_SECOND    = SECOND / 2;
    localparam QUARTER_SECOND = SECOND / 4;
    localparam EIGHTH_SECOND  = SECOND / 8;

    reg [15:0] duty_cycle = DUTY_CYCLE_MIN;
    reg direction = 1'b1;

    reg [23:0] fade_counter = 0;
    localparam FADE_STEP_DELAY = 16'd500;

    wire pwm_out;

    PWM pwm_inst (
        .clk(clk),
        .rst_n(rst_n),
        .duty_cycle(duty_cycle),
        .period(PWM_CLK_PERIOD),
        .pwm_out(pwm_out)
    );

    always @(posedge clk) begin
        if (!rst_n) begin
            duty_cycle   <= DUTY_CYCLE_MIN;
            direction    <= 1'b1;
            fade_counter <= 0;
        end else begin
            if (fade_counter >= FADE_STEP_DELAY) begin
                fade_counter <= 0;

                if (direction) begin
                    if (duty_cycle < DUTY_CYCLE_MAX)
                        duty_cycle <= duty_cycle + 1;
                    else
                        direction <= 1'b0;
                end else begin
                    if (duty_cycle > DUTY_CYCLE_MIN)
                        duty_cycle <= duty_cycle - 1;
                    else
                        direction <= 1'b1;
                end
            end else begin
                fade_counter <= fade_counter + 1;
            end
        end
    end

    assign leds = {8{pwm_out}};

endmodule