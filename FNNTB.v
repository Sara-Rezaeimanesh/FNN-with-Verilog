`timescale 1ns/1ns
module FNNTB();	reg clk, rst;	wire done;	wire [3:0] pred;	wire [9:0]counter;	wire [3:0] acout;
	reg [9:0] tp;	FNN fnn(clk, rst, pred, done, counter);
	get_label gl(counter-1'b1, 1'b1, acout);	always		#25 clk = ~clk;	initial begin		clk = 1'b0;
		tp = 9'b0;
		rst = 1'b1;
		#30 rst = 1'b0;	end	always @(counter) begin
		#5
		$display("acout: %d, pred: %d", acout, pred);		if(acout == pred)			tp = tp+1; 	end
	always @(done) 
		$stop;

endmodule
