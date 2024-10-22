module Adder (input [7:0] In01, In02, output reg [7:0] out); 
	always @(*) 
	begin out = In01 + In02; 
	end 
	endmodule
	