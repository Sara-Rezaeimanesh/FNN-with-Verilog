`timescale 1ns/1ns
module register#(parameter size = 8)(input clk, ld,  input [size - 1:0] in, output reg [size-1 : 0] out);

always@(posedge clk)begin
	if(ld)
     		out <= in; 
end
endmodule
