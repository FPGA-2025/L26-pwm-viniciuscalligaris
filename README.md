# Modulação por Largura de Pulsos (PWM)

A Modulação por Largura de Pulso (PWM — *Pulse Width Modulation*) é uma técnica de controle amplamente utilizada em sistemas digitais para regular a potência fornecida a dispositivos eletrônicos como motores, LEDs, aquecedores e conversores de energia. Isso é feito por meio da variação da **largura (duração)** dos pulsos de um sinal digital periódico, enquanto a frequência do sinal é mantida constante. Essa técnica permite controlar de forma eficiente a energia média entregue a uma carga, sem grandes perdas por dissipação térmica.

A PWM está presente em diversas aplicações da engenharia eletrônica, incluindo sistemas embarcados, interfaces homem-máquina, controle de motores, fontes chaveadas e automação industrial.

---

## O que é PWM

Um sinal PWM é composto por pulsos periódicos de largura variável. Os dois principais parâmetros que o definem são:

* **Duty Cycle (DC)**: É a razão entre o tempo em que o sinal permanece em nível alto (1) e o período total do ciclo. É expresso em porcentagem.

  * Exemplo: DC = 50% → o sinal permanece alto durante metade do ciclo.

* **Frequência (f)**: É o número de ciclos completos por segundo, medido em Hertz (Hz).

  * Exemplo: f = 1 kHz → 1000 ciclos por segundo.

O sinal PWM alterna entre os estados "ligado" e "desligado", e a carga responde à média do valor do sinal ao longo do tempo.

---

## Aplicações do PWM

* Controle de velocidade de motores (ex.: motores DC e brushless).
* Controle de intensidade luminosa em LEDs.
* Conversão e regulação de energia em fontes chaveadas.
* Sinais de controle para servomecanismos.
* Geração de tons sonoros em sistemas embarcados.
* Controle térmico em sistemas de aquecimento.

---

## Objetivo do Laboratório

Neste laboratório, você deverá desenvolver um controlador PWM capaz de gerar um sinal modulado a partir dos parâmetros `duty_cycle` e `period`. Além disso, será necessário criar um segundo módulo que instancie o gerador PWM, configure seu funcionamento e aplique sua saída para realizar um **efeito de fade (suave transição de brilho)** nos LEDs da placa.

---

## Funcionamento do PWM

O sinal PWM será gerado com base nos dois parâmetros fornecidos:

* **Duty Cycle**: Representa a fração do período em que o sinal está ativo (nível alto).
* **Período (Period)**: Define o tempo de duração de cada ciclo completo do sinal.

A combinação desses parâmetros define a forma final do sinal PWM, e por consequência, a intensidade de energia entregue à carga.

### Exemplo de Sinal PWM (Duty Cycle = 50%)

| Tempo | Sinal PWM      |
| ----- | -------------- |
| t0    | 0              |
| t1    | 1 (↑)          |
| t2    | 1              |
| t3    | 0 (↓)          |
| t4    | 0  (novo ciclo)|
| t5    | 1              |

---

## Descrição dos Módulos

### `PWM`

Este módulo é responsável por gerar um sinal PWM com base nos valores fornecidos para o duty cycle e o período.

#### Entradas:

* `clk`: clock do sistema.
* `rst_n`: reset síncrono, ativo em nível lógico baixo.
* `duty_cycle`: valor de 16 bits (0 a 65536), representando o duty cycle como uma fração do período.
* `period`: valor de 16 bits (0 a 65536), representando o período total do sinal.

#### Saída:

* `pwm_out`: saída do sinal PWM gerado (1 bit).

##### Template:

```verilog
module PWM (
    input  wire clk,
    input  wire rst_n,
    input  wire [15:0] duty_cycle, // duty cycle = period * duty_cycle
    input  wire [15:0] period,     // clk_freq / pwm_freq = period
    output wire pwm_out
);
    // Implementação aqui
endmodule
```

---

### `PWM_Control`

Este módulo é responsável por controlar o gerador PWM. Ele deverá configurar o período do PWM para operar em **1.25 kHz** (frequência fixa), além de realizar um efeito de **fade** nos LEDs, variando suavemente o duty cycle entre 0.0025% e 70%.

#### Entradas:

* `clk`: clock do sistema.
* `rst_n`: reset síncrono, ativo em nível lógico baixo.

#### Saídas:

* `leds`: valor de 8 bits, conectados aos LEDs da placa.

##### Template:

```verilog
module PWM_Control #(
    parameter CLK_FREQ = 25_000_000
) (
    input  wire clk,
    input  wire rst_n,
    output wire [7:0] leds
);
    // Implementação aqui
endmodule
```

---

## Execução da Atividade

1. Implemente os dois módulos conforme os templates acima.
2. Utilize os arquivos de teste e scripts fornecidos no repositório para validar seu projeto.
3. Execute o comando `./run-all.sh` para rodar os testes automáticos.

   * Será exibido `OK` para testes aprovados.
   * Será exibido `ERRO` para testes que falharem.

---


## Entrega

Realize um *commit* no repositório do **GitHub Classroom**. O sistema de correção automática irá validar sua implementação e atribuir uma nota com base nos testes executados.

### Execução na Placa Remota

Após realizar um *push* do seu código para o repositório do GitHub Classroom, ele será automaticamente colocado em uma **fila de execução** para ser testado na placa FPGA remota.
Você pode acompanhar o status da execução diretamente no site: [embarcatechfpga.lsc.ic.unicamp.br](https://embarcatechfpga.lsc.ic.unicamp.br)

Se tiver dúvidas sobre como utilizar a infraestrutura remota, consulte o guia disponível no repositório em: [`utils/guia_remoto.md`](utils/guia_remoto.md)



> **Dica:**
>
> * **Não modifique os arquivos de correção**, pois isso poderá invalidar os testes automáticos.
> * Para entender como os testes funcionam, consulte o script `run.sh` presente no repositório.
> * Um `Makefile` também está disponível e simula o mesmo processo de execução utilizado no servidor remoto. Sinta-se à vontade para analisá-lo e executá-lo localmente.
> * Embora a síntese e instalação na placa sejam melhor abordadas em atividades futuras, você já pode preparar seu ambiente local caso tenha interesse.
>
>   * Guia de instalação das ferramentas: [`utils/instalacao.md`](utils/instalacao.md)
>   * Processo de síntese descrito no Capítulo 1 do manual: [`utils/manual.pdf`](utils/manual.pdf)
