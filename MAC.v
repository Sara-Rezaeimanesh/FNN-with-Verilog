`timescale 1ns/1ns
module MAC_62input(input clk, input[1:0] counter_4, input [8*8-1:0] in, input [8*8-1:0] weight, output reg [20:0] out);

	reg [20:0] ans_mul1, ans_mul2, ans_mul3, ans_mul4, ans_mul5, ans_mul6, ans_mul7, ans_mul8;
	reg [13:0] temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8;
	always@(posedge clk)begin
	if(counter_4 == 2'b01)begin
	 temp1 = in[6:0]*weight[6:0];
	 temp2 = in[14:8]*weight[14:8];
	 temp3 = in[22:16]*weight[22:16];
	 temp4 = in[30:24]*weight[30:24];
	 temp5 = in[38:32]*weight[38:32];
	 temp6 = in[46:40]*weight[46:40];
	 temp7 = in[54:48]*weight[54:48];
	 temp8 = in[62:56]*weight[62:56];
	 ans_mul1 = {in[7]^ weight[7],6'b0,   temp1};
	 ans_mul2 = {in[15]^weight[15],6'b0,  temp2};
         ans_mul3 = {in[23]^weight[23],6'b0,  temp3};
	 ans_mul4 = {in[31]^weight[31],6'b0,  temp4};
	 ans_mul5 = {in[39]^weight[39],6'b0,  temp5};
	 ans_mul6 = {in[47]^weight[47],6'b0,  temp6};
	 ans_mul7 = {in[55]^weight[55],6'b0,  temp7};
	 ans_mul8 = {in[63]^weight[63],6'b0,  temp8};
	end
	end

	wire[20:0] ans_sum1, ans_sum2, ans_sum3, ans_sum4, ans_sum5, ans_sum6;
	
	adder a1(ans_mul1, ans_mul2, ans_sum1);
	adder a2(ans_mul3, ans_mul4, ans_sum2);
	adder a3(ans_mul5, ans_mul6, ans_sum3);
	adder a4(ans_mul7, ans_mul8, ans_sum4);

	adder a5(ans_sum1, ans_sum2, ans_sum5);
	adder a6(ans_sum3, ans_sum4, ans_sum6);

	wire [20:0] out_temp;
	adder a7(ans_sum5, ans_sum6, out_temp);
	
	
	always@(posedge clk)begin
	    if(counter_4 == 2'b10)
		out <= out_temp;
	end
	
endmodule

module adder(input [20:0] a, b, output reg[20:0] ans);
	always@(a, b) begin
		if(a[20] ^ b[20])
			begin          
				if(a[19:0] > b[19:0])
					ans = {a[20], a[19:0] - b[19:0]};
				else
					ans = {~a[20],b[19:0] - a[19:0]};
			end
		else
			ans = {a[20],  a[19:0] + b[19:0]};
	end


endmodule
