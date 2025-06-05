module PWM (
    input wire clk,
    input wire rst_n,
    input wire [15:0] duty_cycle, // duty_cycle = period * duty_porcent, 0 <= duty_porcent <= 1
    input wire [15:0] period, // clk_freq / pwm_freq = period
    output wire pwm_out
);

    reg [15:0] counter;               

    always @(posedge clk) begin
        if (!rst_n) begin
            counter <= 16'd0;
        end else begin
            if (counter >= period - 1)
                counter <= 16'd0;
            else
                counter <= counter + 16'd1;
        end
    end

    assign pwm_out = (counter < duty_cycle) ? 1'b1 : 1'b0;

endmodule
