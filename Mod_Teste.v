`default_nettype none //Comando para desabilitar declaração automática de wires
 //Clocks
module Mod_Teste(
input CLOCK_27, CLOCK_50,
//Chaves e Botoes
input [3:0] KEY,
input [17:0] SW,
//Displays de 7 seg e LEDs
output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
output [8:0] LEDG,
output [17:0] LEDR,
//Serial
output UART_TXD,
input UART_RXD,
inout [7:0] LCD_DATA,
output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS,
//GPIO
inout [35:0] GPIO_0, GPIO_1
);
assign GPIO_1 = 36'hzzzzzzzzz;
assign GPIO_0 = 36'hzzzzzzzzz;
assign LCD_ON = 1'b1;
assign LCD_BLON = 1'b1;
wire [7:0] w_d0x0, w_d0x1, w_d0x2, w_d0x3, w_d0x4, w_d0x5,
w_d1x0, w_d1x1, w_d1x2, w_d1x3, w_d1x4, w_d1x5;
LCD_TEST MyLCD (
.iCLK ( CLOCK_50 ),
.iRST_N ( KEY[0] ),
.d0x0(w_d0x0),.d0x1(w_d0x1),.d0x2(w_d0x2),.d0x3(w_d0x3),.d0x4(w_d0x4),.d0x5(w_d0x5),
.d1x0(w_d1x0),.d1x1(w_d1x1),.d1x2(w_d1x2),.d1x3(w_d1x3),.d1x4(w_d1x4),.d1x5(w_d1x5),
.LCD_DATA( LCD_DATA ),
.LCD_RW ( LCD_RW ),
.LCD_EN ( LCD_EN ),
.LCD_RS ( LCD_RS )
);



//---------- modifique a partir daqui --------


//Mux_2x1_8B Mux_2x1(.i0(SW[7:0]), .i1(SW[15:8]), .sel(SW[17]), .out(LEDR[7:0]));
/*module Mux_2x1_8B(input[7:0]i0, input [7:0]i1, input sel , output reg [7:0]out);

always @*
out = sel ? i1:i0; 
endmodule */

//Sprint2


/*wire [3:0]Fio1,fio2;
wire [6:0]fio7seg,fioaux;
wire fioclk;

Decodificador7Seg (.entrada(Fio1), .saida(fioaux));
assign  Fio1[3:0]=SW[11:8];
assign HEX0[0:6]=fioaux[6:0];

DivisorClk(.clk(CLOCK_50),.clkDiv(fioclk));
assign LEDG[0]= fioclk;

contador (.clk(fioclk),.reset(KEY[1]),.cont(fio2));

Decodificador7Seg (.entrada(fio2), .saida(fio7seg));

assign HEX4[0:6] = fio7seg;*/

//Sprint3
/*BancoRegistradores Bank1 (.wd3(SW[7:0]), .wa3(SW[16:14]), .ra1(SW[13:11]),.ra2(SW[10:8]), . we3(SW[17]),.clk(KEY[1]),. rst(KEY[2.]), .rd1(w_d0x0), .rd2(w_d0x1)) ;

 
assign LEDG[8]= ~KEY[1];


Decodificador7Seg  Dec1(.entrada(SW[3:0]), .saida(HEX0[0:6]));

Decodificador7Seg  Dec2(.entrada(SW[7:4]), .saida(HEX1[0:6]));*/


//Sprint 4


// --- Fios Auxiliares ---
/*wire [7:0]w_rd1SrcA;
wire [7:0]w_rd2;
wire [7:0]w_SrcB;

//Atribuições 

assign w_d0x0 = w_rd1SrcA;
assign w_d1x0 = w_rd2;
assign w_d1x1 = w_SrcB;

//Instanciação

Decodificador7Seg U1(.entrada(SW[3:0]),.saida(HEX0[0:6]));
Decodificador7Seg U2(.entrada(SW[7:4]),.saida(HEX1[0:6]));
BancoRegistradores Bank2 (.wd3(SW[7:0]), .wa3(SW[16:14]), .ra1(SW[13:11]),.ra2(3'b010), . we3(1'b1),.clk(KEY[1]),. rst(KEY[2]), .rd1(w_rd1SrcA), .rd2(w_rd2)) ;
mux2x1 M(.I0(w_rd2),.Sel(SW[17]),.F(w_SrcB));
ula M4(.SrcA(w_rd1SrcA),.SrcB(w_SrcB),.ULAControl(SW[10:8]),.ULAResult(w_d0x4),.Z(LEDG[0]));*/


//sprint 5 

/*wire [31:0] w_inst;
wire [7:0] w_rd1SrcA, w_rd2, w_SrcB,  w_ULAResultWd3, w_PC;
wire [2:0] w_ULAControl;
wire w_RegWrite,w_ULASrc;

// decodificadores
Decodificador7Seg Decod0(.entrada(w_inst[3:0]), .saida(HEX0[0:6])); 
Decodificador7Seg Decod1(.entrada(w_inst[7:4]), .saida(HEX1[0:6])); 
Decodificador7Seg Decod2(.entrada(w_inst[11:8]), .saida(HEX2[0:6])); 
Decodificador7Seg Decod3(.entrada(w_inst[15:12]), .saida(HEX3[0:6])); 
Decodificador7Seg Decod4(.entrada(w_inst[19:16]), .saida(HEX4[0:6])); 
Decodificador7Seg Decod5(.entrada(w_inst[23:20]), .saida(HEX5[0:6])); 
Decodificador7Seg Decod6(.entrada(w_inst[27:24]), .saida(HEX6[0:6])); 
Decodificador7Seg Decod7(.entrada(w_inst[31:28]), .saida(HEX7[0:6])); 

PC (.clk(KEY[1]),.rst(KEY[2]),.PC(w_PC));

Instr_Mem (.A(w_PC), .RD(w_inst)); 

Control_Unit (.OP(w_inst[6:0]), .Funct3(w_inst[14:12]), .Funct7(w_inst[31:25]), .ULAControl(w_ULAControl), .ULASrc(w_ULASrc), .RegWrite(w_RegWrite));

BancoRegistradores ( .clk(KEY[1]), .we3(w_RegWrite), .rst(KEY[2]), .wd3(w_ULAResultWd3), .ra1(w_inst[19:15]) ,.ra2(w_inst[24:20]), .wa3(w_inst[11:7]) ,.rd1(w_rd1SrcA) ,.rd2(w_rd2),
.r0(w_d0x0), .r1(w_d0x1), .r2(w_d0x2), .r3(w_d0x3), .r4(w_d1x0), .r5(w_d1x1), .r6(w_d1x2), .r7(w_d1x3));

mux2x1 (.entrada0(w_rd2),.entrada1(w_inst[31:20]),.Sel(w_ULASrc),.saida(w_SrcB));

Ula (.SrcA(w_rd1SrcA),.SrcB(w_SrcB),.ULAControl(w_ULAControl),.ULAResult(w_ULAResultWd3),.Z(LEDG[0]));

assign w_d0x4=w_PC;

assign LEDR[2:0]= w_ULAControl;
assign LEDR[4]= w_RegWrite;
assign LEDR[3]= w_ULASrc;
assign w_d1x4 = w_ULAResultWd3;
*/

//Sprint 6
 /*
wire [31:0] w_Inst;
wire [7:0] w_rd1SrcA, w_rd2, w_SrcB,  w_ULAResultWd3, w_PC, w_Wd3, w_Imm, w_RData;
wire [2:0] w_ULAControl;
wire w_RegWrite,w_ULASrc,w_MemWrite,w_ImmSrc, w_ResultSrc, w_clock; 

assign LEDG[8]=w_clock;
assign LEDR[4:2]=w_ULAControl[2:0];
assign LEDR[0]=w_ResultSrc;
assign LEDR[1]=w_MemWrite;
assign LEDR[5]=w_ULASrc;
assign LEDR[6]=w_ImmSrc;
assign LEDR[7]=w_RegWrite;
assign w_d0x4=w_PC;

Decodificador7Seg Decod0(.entrada(w_Inst[3:0]), .saida(HEX0[0:6])); 
Decodificador7Seg Decod1(.entrada(w_Inst[7:4]), .saida(HEX1[0:6])); 
Decodificador7Seg Decod2(.entrada(w_Inst[11:8]), .saida(HEX2[0:6])); 
Decodificador7Seg Decod3(.entrada(w_Inst[15:12]), .saida(HEX3[0:6])); 
Decodificador7Seg Decod4(.entrada(w_Inst[19:16]), .saida(HEX4[0:6])); 
Decodificador7Seg Decod5(.entrada(w_Inst[23:20]), .saida(HEX5[0:6])); 
Decodificador7Seg Decod6(.entrada(w_Inst[27:24]), .saida(HEX6[0:6])); 
Decodificador7Seg Decod7(.entrada(w_Inst[31:28]), .saida(HEX7[0:6])); 

DivisorClk(.clk(CLOCK_50),.clkDiv(w_clock));

PC (.clk(w_clock),.rst(KEY[2]),.PC(w_PC));

Instr_Mem (.A(w_PC), .RD(w_Inst)); 

Control_Unit (.OP(w_Inst[6:0]), .Funct3(w_Inst[14:12]), .Funct7(w_Inst[31:25]), .ULAControl(w_ULAControl), .ULASrc(w_ULASrc), .RegWrite(w_RegWrite) , .MemWrite(w_MemWrite), .ImmSrc(w_ImmSrc), .ResultSrc(w_ResultSrc));

BancoRegistradores ( .clk(w_clock), .we3(w_RegWrite), .rst(KEY[2]), .wd3(w_Wd3), .ra1(w_Inst[19:15]) ,.ra2(w_Inst[24:20]), .wa3(w_Inst[11:7]) ,.rd1(w_rd1SrcA) ,.rd2(w_rd2),
.r0(w_d0x0), .r1(w_d0x1), .r2(w_d0x2), .r3(w_d0x3), .r4(w_d1x0), .r5(w_d1x1), .r6(w_d1x2), .r7(w_d1x3));


mux2x1 A(.entrada0(w_Inst[31:20]), .entrada1({w_Inst[31:25], w_Inst[11:7]}),.Sel(w_ImmSrc),.saida(w_Imm));
mux2x1 B(.entrada0(w_rd2),.entrada1(w_Imm),.Sel(w_ULASrc),.saida(w_SrcB));
mux2x1 C(.entrada0(w_ULAResultWd3),.entrada1(w_RData),.Sel(w_ResultSrc),.saida(w_Wd3));


Ula (.SrcA(w_rd1SrcA),.SrcB(w_SrcB),.ULAControl(w_ULAControl),.ULAResult(w_ULAResultWd3),.Z(LEDG[0]));
RAM (.WD(w_rd2),.A(w_ULAResultWd3) ,.WE(w_MemWrite), .clk(w_clock), .rst(KEY[2]), .RD(w_RData));

*/
//Sprint7
/* 
// Definição de sinais para o processador
assign w_ImmPC = w_Imm + w_PC; // Calcula o endereço de destino para saltos (PC + imediato)
wire [31:0] w_Inst; // Armazena a instrução atual
wire [7:0] w_rd1SrcA, w_rd2, w_SrcB, w_ULAResultWd3, w_PC, w_PCIn, w_Wd3, w_Imm, w_RData, w_ImmPC, w_DataOut, w_DataIn, w_RegData; // Vários sinais de 8 bits
wire [2:0] w_ULAControl; // Controle da ULA (Unidade Lógica Aritmética)
wire w_RegWrite, w_ULASrc, w_MemWrite, w_ResultSrc, w_clock, w_Branch, w_Z; // Sinais de controle e status
wire [1:0] w_ImmSrc; // Seleção do tipo de imediato

// Atribuição de LEDs para monitoramento de sinais
assign LEDG[8] = w_clock; // Mostra o clock no LED verde 8
assign LEDR[4:2] = w_ULAControl[2:0]; // Mostra o controle da ULA nos LEDs vermelhos 4 a 2
assign LEDR[0] = w_ResultSrc; // Mostra a fonte do resultado no LED vermelho 0
assign LEDR[1] = w_MemWrite; // Mostra o controle de escrita na memória no LED vermelho 1
assign LEDR[5] = w_ULASrc; // Mostra a seleção da fonte da ULA no LED vermelho 5
assign LEDR[6] = w_ImmSrc; // Mostra a seleção do tipo de imediato no LED vermelho 6
assign LEDR[7] = w_RegWrite; // Mostra o controle de escrita no registrador no LED vermelho 7

// Atribuição de dados para displays
assign w_d0x4 = w_PC; // Mostra o contador de programa em um display específico
assign w_d1x4 = w_DataOut; // Mostra a saída de dados de memória em outro display
assign w_DataIn = SW[7:0]; // Entrada de dados vinda dos switches

// Decodificadores de 7 segmentos para exibir a instrução
Decodificador7Seg Decod0(.entrada(w_Inst[3:0]), .saida(HEX0[0:6])); // Exibe os bits 3:0 da instrução no display HEX0
Decodificador7Seg Decod1(.entrada(w_Inst[7:4]), .saida(HEX1[0:6])); // Exibe os bits 7:4 da instrução no display HEX1
Decodificador7Seg Decod2(.entrada(w_Inst[11:8]), .saida(HEX2[0:6])); // Exibe os bits 11:8 no display HEX2
Decodificador7Seg Decod3(.entrada(w_Inst[15:12]), .saida(HEX3[0:6])); // Exibe os bits 15:12 no display HEX3
Decodificador7Seg Decod4(.entrada(w_Inst[19:16]), .saida(HEX4[0:6])); // Exibe os bits 19:16 no display HEX4
Decodificador7Seg Decod5(.entrada(w_Inst[23:20]), .saida(HEX5[0:6])); // Exibe os bits 23:20 no display HEX5
Decodificador7Seg Decod6(.entrada(w_Inst[27:24]), .saida(HEX6[0:6])); // Exibe os bits 27:24 no display HEX6
Decodificador7Seg Decod7(.entrada(w_Inst[31:28]), .saida(HEX7[0:6])); // Exibe os bits 31:28 no display HEX7

// Divisor de clock para reduzir a frequência do sinal de clock
DivisorClk(.clk(CLOCK_50), .clkDiv(w_clock)); // Divide o clock de 50 MHz para uma frequência mais baixa

// Contador de Programa (PC)
PC (.PCin(w_PCIn), .clk(w_clock), .rst(KEY[2]), .PC(w_PC)); // Atualiza o PC a cada ciclo de clock, com reset ativo baixo

// Memória de Instruções
Instr_Mem (.A(w_PC), .RD(w_Inst)); // Busca a instrução da memória usando o endereço PC

// Unidade de Controle para gerar sinais de controle com base na instrução atual
Control_Unit (.OP(w_Inst[6:0]), .Funct3(w_Inst[14:12]), .Funct7(w_Inst[31:25]), .ULAControl(w_ULAControl), .ULASrc(w_ULASrc), .RegWrite(w_RegWrite), .MemWrite(w_MemWrite), .ImmSrc(w_ImmSrc), .ResultSrc(w_ResultSrc), .Branch(w_Branch));

// Banco de Registradores
BancoRegistradores (.clk(w_clock), .we3(w_RegWrite), .rst(KEY[2]), .wd3(w_Wd3), .ra1(w_Inst[19:15]), .ra2(w_Inst[24:20]), .wa3(w_Inst[11:7]), .rd1(w_rd1SrcA), .rd2(w_rd2), .r0(w_d0x0), .r1(w_d0x1), .r2(w_d0x2), .r3(w_d0x3), .r4(w_d1x0), .r5(w_d1x1), .r6(w_d1x2), .r7(w_d1x3)); // Gerencia registradores para leitura/escrita

// Multiplexadores (Muxes) para seleção de entradas
mux2x1 A(.entrada0((w_PC + 8'h4)), .entrada1(w_ImmPC), .Sel((w_Branch && w_Z)), .saida(w_PCIn)); // Seleciona o próximo endereço do PC (sequencial ou baseado em desvio)
mux2x1 B(.entrada0(w_rd2), .entrada1(w_Imm), .Sel(w_ULASrc), .saida(w_SrcB)); // Seleciona a entrada da ULA entre o registrador e um imediato
mux2x1 C(.entrada0(w_ULAResultWd3), .entrada1(w_RegData), .Sel(w_ResultSrc), .saida(w_Wd3)); // Seleciona a fonte de dados para escrita em registradores
Mux4 (.a(w_Inst[31:20]), .b({w_Inst[31:25], w_Inst[11:7]}), .c({w_Inst[7], w_Inst[30:25], w_Inst[11:8], 1'b0}), .sel(w_ImmSrc), .saida(w_Imm)); // Seleciona o tipo de imediato com base na instrução

// Unidade Lógica Aritmética (ULA)
Ula (.SrcA(w_rd1SrcA), .SrcB(w_SrcB), .ULAControl(w_ULAControl), .ULAResult(w_ULAResultWd3), .Z(w_Z)); // Executa operações aritméticas e lógicas

// Memória RAM
RAM (.WD(w_rd2), .A(w_ULAResultWd3), .WE(w_MemWrite), .clk(w_clock), .rst(KEY[2]), .RD(w_RData)); // Lê/escreve dados na memória

// Interface de saída paralela (usada para dispositivos externos)
ParallelOut (.EN(w_MemWrite), .Address(w_ULAResultWd3), .rst(KEY[2]), .clk(w_clock), .RedData(w_rd2), .DataOut(w_DataOut)); // Envia dados para dispositivos externos

// Interface de entrada paralela (usada para dispositivos externos)
ParallelIn (.MemData(w_RData), .Datain(w_DataIn), .Address(w_ULAResultWd3), .RegData(w_RegData)); // Recebe dados de dispositivos externos

// Atribuição do LED para mostrar a flag de zero (Z)
assign LEDG[0] = w_Z; // Mostra o sinal zero da ULA no LED verde 0

endmodule
*/
//SPRINT 9 LED DA BAGUNÇA

// Declaração explícita de todos os sinais (wires)
wire w_clock;            // Sinal de clock reduzido
wire [31:0] w_Inst;      // Instrução atual
wire [7:0] w_PC, w_PCIn, w_Wd3, w_rd1SrcA, w_rd2, w_Imm, w_SrcB, w_ULAResultWd3, w_DataOut, w_DataIn, w_RegData, w_ImmPC; // Sinais de 8 bits
wire [2:0] w_ULAControl; // Controle da ULA (Unidade Lógica Aritmética)
wire w_RegWrite, w_ULASrc, w_MemWrite, w_ResultSrc, w_Branch, w_Z; // Sinais de controle
wire [1:0] w_ImmSrc;     // Seleção do tipo de imediato
wire [31:0] w_RData;     // Sinal de 32 bits para leitura da RAM
	 
// --- Instanciando o divisor de clock para reduzir a frequência ---
DivisorClk div_clk(
	.clk(CLOCK_50),
	.clkDiv(w_clock)
    );

// --- Instancia o módulo de animação de LEDs ---
LED_Animation led_control (
	.clock(w_clock),    // Clock reduzido
   .reset(KEY[2]),     // Reset (ativo alto)
   .data_in(SW[7:0]),  // Entrada paralela das chaves
   .led_out(LEDR[7:0]) // Saída para os LEDs
    );

// --- Conectando os displays de 7 segmentos para exibir a instrução ---
Decodificador7Seg Decod0(.entrada(w_Inst[3:0]), .saida(HEX0[0:6]));
Decodificador7Seg Decod1(.entrada(w_Inst[7:4]), .saida(HEX1[0:6]));
Decodificador7Seg Decod2(.entrada(w_Inst[11:8]), .saida(HEX2[0:6]));
Decodificador7Seg Decod3(.entrada(w_Inst[15:12]), .saida(HEX3[0:6]));
Decodificador7Seg Decod4(.entrada(w_Inst[19:16]), .saida(HEX4[0:6]));
Decodificador7Seg Decod5(.entrada(w_Inst[23:20]), .saida(HEX5[0:6]));
Decodificador7Seg Decod6(.entrada(w_Inst[27:24]), .saida(HEX6[0:6]));
Decodificador7Seg Decod7(.entrada(w_Inst[31:28]), .saida(HEX7[0:6]));

// --- Contador de Programa (PC) ---
 PC pc_module (
	.PCin(w_PCIn),
	.clk(w_clock),
   .rst(KEY[2]),
	.PC(w_PC)
    );

// --- Memória de Instruções ---
Instr_Mem instr_mem (
	.A(w_PC),
	.RD(w_Inst)
    );

// --- Unidade de Controle ---
Control_Unit control_unit (
	.OP(w_Inst[6:0]),
   .Funct3(w_Inst[14:12]),
   .Funct7(w_Inst[31:25]),
   .ULAControl(w_ULAControl),
   .ULASrc(w_ULASrc),
   .RegWrite(w_RegWrite),
   .MemWrite(w_MemWrite),
   .ImmSrc(w_ImmSrc),
   .ResultSrc(w_ResultSrc),
   .Branch(w_Branch)
    );

// --- Banco de Registradores ---
BancoRegistradores banco_reg (
    .clk(w_clock),
    .we3(w_RegWrite),
    .rst(KEY[2]),
    .wd3(w_Wd3),
    .ra1(w_Inst[19:15]),
    .ra2(w_Inst[24:20]),
   .wa3(w_Inst[11:7]),
   .rd1(w_rd1SrcA),
	.rd2(w_rd2)
    );
	 
// --- Módulos Muxes ---
mux2x1 mux_a (
	.entrada0((w_PC + 8'h4)),
   .entrada1(w_ImmPC),
   .Sel((w_Branch && w_Z)),
   .saida(w_PCIn)
    );
    mux2x1 mux_b (
    .entrada0(w_rd2),
    .entrada1(w_Imm),
    .Sel(w_ULASrc),
	 .saida(w_SrcB)
    );
    mux2x1 mux_c (
     .entrada0(w_ULAResultWd3),
     .entrada1(w_RegData),
     .Sel(w_ResultSrc),
     .saida(w_Wd3)
    );
    Mux4 mux_imm (
     .a(w_Inst[31:20]),
     .b({w_Inst[31:25], w_Inst[11:7]}),
     .c({w_Inst[7], w_Inst[30:25], w_Inst[11:8], 1'b0}),
     .sel(w_ImmSrc),
     .saida(w_Imm)
	  );
    
// --- ULA ---
Ula ula (
     .SrcA(w_rd1SrcA),
     .SrcB(w_SrcB),
     .ULAControl(w_ULAControl),
	  .ULAResult(w_ULAResultWd3),
     .Z(w_Z)
    );
    
// --- Memória RAM ---
RAM ram (
     .WD(w_rd2),
     .A(w_ULAResultWd3),
     .WE(w_MemWrite),
	  .clk(w_clock),
	  .rst(KEY[2]),
     .RD(w_RData)
    );

 // --- Interface de Saída Paralela ---
ParallelOut ParallelOut (
      .EN(w_MemWrite),
      .Address(w_ULAResultWd3),
      .rst(KEY[2]),
      .clk(w_clock),
      .RedData(w_rd2),
      .DataOut(w_DataOut)
    );

// --- Interface de Entrada Paralela ---
ParallelIn ParallelIn (
      .MemData(w_RData),
      .Datain(w_DataIn),
      .Address(w_ULAResultWd3),
      .RegData(w_RegData)
    );

// --- Atribuição de dados e sinais para monitoramento ---
assign w_DataIn = SW[7:0]; // Entrada de dados vinda dos switches
assign LEDG[0] = w_Z; // Mostra o sinal zero da ULA no LED verde 0
assign LEDG[8] = w_clock; // Mostra o clock no LED verde 8

endmodule
