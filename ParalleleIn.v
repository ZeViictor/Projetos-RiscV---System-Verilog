module ParallelIn (input [7:0] MemData, Datain, Address, output  [7:0] RegData);

wire en; 
assign en = (((Address == 8'hff) ? 1'b1 : 1'b0));
assign RegData = en ? Datain : MemData;

endmodule 