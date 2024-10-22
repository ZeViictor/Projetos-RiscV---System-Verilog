module RAM(
    input wire [7:0] A,      // Entrada de endereço (8 bits)
    input wire [7:0] WD,     // Entrada de dados (8 bits)
    output wire [7:0] RD,    // Saída de dados (8 bits)
    input wire WE,           // Habilitar escrita (1 bit)
    input wire rst,          // Reset (1 bit)
    input wire clk           // Clock (1 bit)
);

    reg [7:0] memory [255:0]; // Array bidimensional para a memória RAM
    integer i;
    always @(posedge clk) begin
        if (!rst) begin
            // Reset da memória
            for (i = 0; i < 256; i = i + 1) begin
                memory[i] <= 8'h00;
            end
        end else begin
            if (WE == 1) begin
                // Escrita sequencial na subida do clock
                memory[A] <= WD;
            end
        end
    end
   
   
    assign RD = memory[A]; 
endmodule
