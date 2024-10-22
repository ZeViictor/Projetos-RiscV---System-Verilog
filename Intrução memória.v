module Instr_Mem(input [7:0] A, output reg [31:0] RD); 
always @(*) 
begin 
case(A) 

8'h00:RD= 32'h00100193; 
8'h04:RD= 32'h0ff00083; 
8'h08:RD= 32'h0030f133; 
8'h0C:RD= 32'h00310463; 
8'h10:RD= 32'h00010863; 
8'h14:RD= 32'h00000233; 
8'h18:RD= 32'h0e400fa3; 
8'h1c:RD= 32'hfe0004e3; 
8'h20:RD= 32'h00300233; 
8'h24:RD= 32'h0e400fa3; 
8'h28:RD= 32'hfc000ee3;  


/*#Carrega a entrada paralela no registrador 1
//sb x1, 0xFF(x0) #Salva o registrador 1 na saída paralela
//beq x0, x0, init #Reinicia o laço
*/
/*
8'h00:RD= 32'h0ff00083; 
8'h04:RD= 32'h0e100fa3; 
8'h08:RD= 32'hfe000ce3;  
*/

default:RD=0; 
endcase 
end 
endmodule
