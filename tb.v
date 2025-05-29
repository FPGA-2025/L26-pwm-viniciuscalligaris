`timescale 1ns/1ps

module tb_PWM();

    // Parâmetros para simulação
    localparam CLK_PERIOD = 2; // clock de 2ns => 500MHz (para simulação rápida)

    // Entradas
    reg clk;
    reg rst_n;
    reg [15:0] duty_cycle;
    reg [15:0] period;

    // Saída
    wire pwm_out;

    // Instanciação do DUT
    PWM dut (
        .clk(clk),
        .rst_n(rst_n),
        .duty_cycle(duty_cycle),
        .period(period),
        .pwm_out(pwm_out)
    );

    // Geração do clock
    initial clk = 0;
    always #(CLK_PERIOD/2) clk = ~clk;

    // Contador para verificar duty cycle
    integer high_count;
    integer total_count;
    integer i;

    // Testes
    initial begin
        $dumpfile("saida_pwm.vcd");
        $dumpvars(0, tb_PWM);

        // Reset inicial
        rst_n = 0;
        duty_cycle = 0;
        period = 0;
        #10;
        rst_n = 1;

        // Teste 1: duty_cycle = 0 -> saída deve ser sempre 0
        duty_cycle = 8'd0;
        period = 8'd10;
        high_count = 0;
        total_count = 20;
        #(CLK_PERIOD * total_count);
        for (i = 0; i < total_count; i = i + 1) begin
            if (pwm_out) high_count = high_count + 1;
            #(CLK_PERIOD);
        end
        if (high_count == 0)
            $display("OK: Teste 1 - pwm_out permaneceu 0 como esperado.");
        else
            $display("ERRO: Teste 1 - pwm_out ficou alto %d vezes, esperado 0.", high_count);

        // Teste 2: duty_cycle = período -> saída deve ser sempre 1
        rst_n = 0; #5; rst_n = 1;
        duty_cycle = 8'd10;
        period = 8'd10;
        high_count = 0;
        #(CLK_PERIOD * total_count);
        for (i = 0; i < total_count; i = i + 1) begin
            if (pwm_out) high_count = high_count + 1;
            #(CLK_PERIOD);
        end
        if (high_count == total_count)
            $display("OK: Teste 2 - pwm_out permaneceu 1 como esperado.");
        else
            $display("ERRO: Teste 2 - pwm_out ficou alto %d vezes, esperado %d.", high_count, total_count);

        // Teste 3: duty_cycle = 50% do período
        rst_n = 0; #5; rst_n = 1;
        duty_cycle = 8'd5;
        period = 8'd10;
        high_count = 0;
        #(CLK_PERIOD * total_count);
        for (i = 0; i < total_count; i = i + 1) begin
            if (pwm_out) high_count = high_count + 1;
            #(CLK_PERIOD);
        end
        if (high_count >= total_count / 2 - 1 && high_count <= total_count / 2 + 1)
            $display("OK: Teste 3 - pwm_out alto por aproximadamente 50%% do tempo.");
        else
            $display("ERRO: Teste 3 - pwm_out alto %d vezes, esperado ~%d.", high_count, total_count/2);

        $finish;
    end

endmodule
