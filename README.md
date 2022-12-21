# RISC-V-PROCESSOR-16BITS
Esse repositório tem como principal objetivo, a construção de um processador simples, baseado no RISC-V, na versão multiciclico. A implementação será feita em verilog, além de ser dividida em 4 partes.

## RISC-V
o RISC-V é um conjunto de instruções (ISA) baseado em princípios RISC (Reduced Instruction Set Computing), desenvolvido desde 2010, na Universidade da Califórnia, em Berkeley. A figura abaixo representa o esquemático do que almejamos ao final do projeto.

![risvprocessor](https://user-images.githubusercontent.com/84240829/208762600-d06da602-40e4-4fb4-8fe1-92daae879fa8.png)

## VERILOG  
Verilog é uma linguagem de descrição de hardware usada para modelar sistemas eletrônicos ao nível de circuito. Essa ferramenta suporta a projeção, verificação e implementação de projetos analógicos, digitais e híbridos em vários níveis de abstração.

## 1ª Parte - Implementação da ULA
A ULA (Unidade de Lógica e Aritmética) é um dos componentes centrais do processador. Sua função é realizar operações aritméticas (soma, subtração, etc.) e lógicas (AND, OR, etc.) entre dois operandos. A largura N do barramento de dados da ULA é, em algumas classificações, utilizada para discriminar o tipo de arquitetura: 8 bits, 16 bits, 32 bits, etc.

A FPGA utilizada inicialmente foi a DE10_LITE, além de usarmos o DE10_Lite_SystemBuilder.exe (executável de configuração da FPGA) para configurar o sistema da FPGA.

![ALUSettingsFPGA](https://user-images.githubusercontent.com/84240829/208765064-9e5d7dbb-16b4-405f-b330-18e6553d0585.png)


Abaixo está o módulo da ULA, que, inicialmente, terá um barramento de 4 bits. nos inputs, um botão mais os switches 0 e 1 definem a operação, os pinos de 2 a 5 definem a segunda parcela da soma, e os pinos de 6 a 9 definem a primeira parcela da soma.

```
module ALU
#(
parameter WIDTH = 4)
(
input [WIDTH-1:0] SrcA,
input [WIDTH-1:0] SrcB,
input [2:0] ALUControl,
output reg [WIDTH-1:0] ALUResult,
output reg Zero
);


always @(*)
    begin
        case(ALUControl)
        3'b000: // Addition
           ALUResult = SrcA + SrcB; 
        3'b001: // Subtraction
           ALUResult = SrcA - SrcB;
          3'b010: //  Logical and 
           ALUResult = SrcA & SrcB;
          3'b011: //  Logical or
           ALUResult = SrcA | SrcB;
          3'b101: // Greater comparison SLT
           ALUResult = (SrcA<SrcB)?8'b1:8'b0;
          default: ALUResult = SrcA + SrcB; 
        endcase
		  
		  Zero = (ALUResult == 0)?8'b1:8'd0;
		  
    end


endmodule
```




```
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module de10_lite_alu(

	//////////// CLOCK //////////
	input 		          		ADC_CLK_10,
	input 		          		MAX10_CLK1_50,
	input 		          		MAX10_CLK2_50,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW
);



//=======================================================
//  REG/WIRE declarations
//=======================================================




//=======================================================
//  Structural coding
//=======================================================

ALU #(
.WIDTH (4))
ALU0 ( .SrcA (SW[3:0]),
.SrcB (SW[7:4]),
.ALUControl ({KEY[0],SW[9:8]}),
.ALUResult (LEDR[3:0]),
.Zero(LEDR[4]));


endmodule
```








## 2ª Parte - Implementação do PC (contador de programa) e do Banco de Registradores.
Os Registradores são circuitos sequenciais formados por Flip-Flops (FF) que, sob o ponto de vista de Organização de Computadores, compõem o nível mais alto da hierarquia de memória. São memórias voláteis (ou seja, seus dados são perdidos quando o circuito é desligado), normalmente compostos por FF Tipo-D ligados em paralelo. Sua função é bastante simples: armazenar um dado de N bits por certo período de tempo.
Já o PC,  é utilizado para indicar, na memória, o endereço da próxima instrução a ser executada. A cada instrução executada, ele é atualizado para apontar para o endereço da próxima instrução a ser executada. 
o PC pode ser implementado tanto como um registrador, acrescido de um circuito dedicado formado por um circuito somador (para incremento de 1) e por um multiplexador (para o desvio de fluxo), ou com um contador (síncrono ou assíncrono) com carga paralela. Para este projeto, vamos utilizar o formado por um contador com carga paralela.

Abaixo está o código verilog do PC

```
	//PC Register
	always @ (posedge clk or posedge reset)
	begin
		if (reset)
			PC <= 0;
		else
			if (PCWrite) 
				PC <= Result;
	end
```
	
## 3ª Parte - Máquina de estado finitos 

