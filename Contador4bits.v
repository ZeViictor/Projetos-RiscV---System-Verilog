module contador (input clk, input reset, output reg [3:0] cont);

reg [3:0]contador= 4'b0000;

always@(posedge clk)
begin
contador = contador + 4'b0001;
if(contador == 4'b1010)
contador = 4'b0000;


if(!reset)
contador=4'b0000;

cont=contador;

end
endmodule
