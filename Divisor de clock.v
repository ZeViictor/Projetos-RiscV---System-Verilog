module DivisorClk(input clk,output reg clkDiv);

reg [24:0]contador;
reg div;

initial 
begin
div= 1'b0;
end

always @(posedge clk)
begin
   if(contador == 12500000)
	begin
	   div <=~ div;
	   contador <= 0;
	end
	else
	   contador <= contador + 1;
	   clkDiv <= div;
	
end
endmodule

