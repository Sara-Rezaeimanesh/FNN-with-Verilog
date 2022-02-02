`timescale 1ns/1ns
module FNNTB();
	reg [9:0] tp;
	get_label gl(counter-1'b1, 1'b1, acout);
		tp = 9'b0;
		rst = 1'b1;
		#30 rst = 1'b0;
		#5
		$display("acout: %d, pred: %d", acout, pred);
	always @(done) 
		$stop;

endmodule