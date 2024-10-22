module LED_Animation (
    input wire clock,     // Clock de entrada
    input wire reset,     // Reset (ativo alto)
    input wire [7:0] data_in, // Entrada paralela
    output wire [7:0] led_out // Saída para os LEDs (deve ser wire para atribuição contínua)
);

    reg [2:0] state; // Registrador para armazenar o estado atual da animação

    // Atribuição contínua dos LEDs com base no estado
    assign led_out = (data_in == 8'b1) ? (8'b00000001 << state) : 8'b0;

    // Bloco sempre para controle da animação de LEDs
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // Reseta o estado para 0
        end else if (data_in == 8'b1) begin
            state <= state + 1'b1; // Avança para o próximo estado
        end
    end

endmodule
