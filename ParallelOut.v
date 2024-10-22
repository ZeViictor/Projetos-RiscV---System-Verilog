module ParallelOut (input EN, rst, clk, input [7:0] Address ,RedData, output reg [7:0] DataOut );

wire en;

assign en = (((Address == 8'hff) ? 1'b1 : 1'b0) & EN);

always@ (posedge clk)
begin
if (en)
DataOut = RedData;

if (!rst)
DataOut=8'b0;

end

endmodule


