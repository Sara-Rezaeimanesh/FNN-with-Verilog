`timescale 1ns/1ns
module MUX8bit(input[7:0] in1, in2, in3, in4, in5, in6, input[2:0] sel, output reg[7:0] out);

	assign out = sel == 3'b0 ? in1 : 
			sel == 3'd1 ? in2 :
			sel == 3'd2 ? in3 :
			sel == 3'd3 ? in4 :
			sel == 3'd4 ? in5 :
			sel == 3'd5 ? in6 : 8'bZ;

endmodule
