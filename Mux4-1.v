module Mux4 ( input [11:0] a,b,c, input [1:0] sel, output reg [11:0] saida) ;

always @*
begin
   case({sel})
2'b00:saida = a;
2'b01:saida = b;
2'b10:saida = c;
default: saida = 0;

endcase
 end
 
 endmodule 