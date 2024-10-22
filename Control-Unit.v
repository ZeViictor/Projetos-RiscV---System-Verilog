module Control_Unit (input  [6:0] OP,
                     input  [2:0] Funct3,
                     input  [6:0] Funct7,
                     output reg [2:0] ULAControl,
							output reg [1:0] ImmSrc,
                     output reg ULASrc, RegWrite,MemWrite,ResultSrc, Branch );
  
  reg [9:0] saida;
  
  always @ (*) begin 
    casex ({OP, Funct3, Funct7})
      {7'b0110011, 3'b000, 7'b0000000}: saida = {1'b1, 2'bxx, 1'b0, 3'b000, 1'b0, 1'b0,1'b0}; // ADD
      {7'b0110011, 3'b000, 7'b0100000}: saida = {1'b1, 2'bxx, 1'b0, 3'b001, 1'b0, 1'b0,1'b0}; // SUB
      {7'b0110011, 3'b111, 7'b0000000}: saida = {1'b1, 2'bxx, 1'b0, 3'b010, 1'b0, 1'b0,1'b0}; // AND
      {7'b0110011, 3'b110, 7'b0000000}: saida = {1'b1, 2'bxx, 1'b0, 3'b011, 1'b0, 1'b0,1'b0}; // OR
      {7'b0110011, 3'b010, 7'b0000000}: saida = {1'b1, 2'bxx, 1'b0, 3'b101, 1'b0, 1'b0,1'b0}; // SLT
      {7'b0010011, 3'b000, 7'bxxxxxxx}: saida = {1'b1, 2'b00, 1'b1, 3'b000, 1'b0, 1'b0,1'b0}; // ADDi 
		{7'b0000011, 3'b000, 7'bxxxxxxx}: saida = {1'b1, 2'b00, 1'b1, 3'b000, 1'b0, 1'b1,1'b0}; // LB
		{7'b0100011, 3'b000, 7'bxxxxxxx}: saida = {1'b0, 2'b01, 1'b1, 3'b000, 1'b1, 1'bx,1'b0}; // SB
		{7'b1100011, 3'b000, 7'bxxxxxxx}: saida = {1'b0, 2'b10, 1'b0, 3'b001, 1'b0, 1'bx,1'b1}; // BEQ
      default : saida = 9'bxxxxxxxx;
		
    endcase
  	
  	{RegWrite, ImmSrc, ULASrc , ULAControl, MemWrite, ResultSrc, Branch} = saida;
	
    
  end
endmodule

