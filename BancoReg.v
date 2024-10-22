module BancoRegistradores (input [7:0] wd3, 
    input [4:0] wa3, ra1, ra2, input we3, clk, rst,  
    output reg [7:0] rd1, rd2, r0,r1,r2,r3,r4,r5,r6,r7
);

reg [7:0] registers [0:7]; // criar um banco com 
integer i;

always @(posedge clk) begin // Monitora na subida do clk 
	if (!rst) begin
		for (i=0; i<8; i=i+1)
        registers[i] <= 8'b0; 		  
    end
	 else
    if (we3) begin // se we3 estiver  ativo, salva o registrador
      registers[wa3] <= wd3; // salvar o valor de wd3 no wa3
		registers[0]<= 8'b0;
	 end	  
end

always @(*) begin
    rd1 = registers[ra1];
    rd2 = registers[ra2];
	 r0 = registers[0];
	 r1 = registers[1];
	 r2 = registers[2];
	 r3 = registers[3];
	 r4 = registers[4];
	 r5 = registers[5];
	 r6 = registers[6];
	 r7 = registers[7];
	
	 
end


endmodule
