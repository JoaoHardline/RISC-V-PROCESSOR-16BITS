# RISC-V-PROCESSOR-16BITS
Esse repositório tem como principal objetivo, a construção de um processador simples, baseado no RISC-V, na versão multiciclico. A implementação será feita em verilog, além de ser dividida em 4 partes.

## RISC-V
o RISC-V é um conjunto de instruções (ISA) baseado em princípios RISC (Reduced Instruction Set Computing), desenvolvido desde 2010, na Universidade da Califórnia, em Berkeley. A figura abaixo representa o esquemático do do que almejamos ao final do projeto.

![risvprocessor](https://user-images.githubusercontent.com/84240829/208762600-d06da602-40e4-4fb4-8fe1-92daae879fa8.png)

## VERILOG  
Verilog é uma linguagem de descrição de hardware usada para modelar sistemas eletrônicos ao nível de circuito. Essa ferramenta suporta a projeção, verificação e implementação de projetos analógicos, digitais e híbridos em vários níveis de abstração.

## 1ª Parte - Implementação da ULA
A ULA (Unidade de Lógica e Aritmética) é um dos componentes centrais do processador. Sua função é realizar operações aritméticas (soma, subtração, etc.) e lógicas (AND, OR, etc.) entre dois operandos. A largura N do barramento de dados da ULA é, em algumas classificações, utilizada para discriminar o tipo de arquitetura: 8 bits, 16 bits, 32 bits, etc.
