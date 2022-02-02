`timescale 1ns/1ns
module FNN(input clk, rst, output[3:0] pred, output done, output[9:0] counter);

	wire sel, mem_read, ld, second;
	wire [3:0] ldhlo;
	wire [1:0] win;
	wire [2:0] counter_8;
	wire [1:0]counter_4;
	Controller c(clk, rst, done, sel, mem_read,ld, second, counter_8, win, ldhlo, counter, counter_4);
	FNNDP fdp(sel, clk, rst, mem_read,ld, second,counter_4, counter_8, ldhlo, counter, win, pred);

endmodule