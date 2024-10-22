module mux2x1(entrada0, entrada1,Sel,saida);

input [7:0]entrada0, entrada1 ;
input Sel;
output reg [7:0]saida;

always @*
begin
   case({Sel})
1'b0:saida = entrada0;
1'b1:saida = entrada1;
endcase
 end
 
 endmodule