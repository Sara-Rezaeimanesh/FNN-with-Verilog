 `timescale 1ns/1ns
module neuron(input clk, input[62*8-1:0] weights, ins, input[7:0] bias, input[2:0] counter_8,input second,input[1:0]counter_4, output[7:0] out);

	wire[20:0] mac_out, ReLU_out;
	reg[20:0] sa_out, temp1, temp2;  
	
	initial begin
		sa_out = 21'b0;
	end

	wire[64*8-1:0] weights_in, ins_in;
	assign weights_in = {16'b0, weights};
	assign ins_in = {16'b0, ins};

	

	MAC_62input mac(clk, counter_4, weights_in[64*counter_8+:64], ins_in[64*counter_8+:64], mac_out);

	// adding mac output and bias
	always@(mac_out, bias) begin
		if(counter_8 == 3'b0) begin
			if((mac_out[20] ^ bias[7])) begin          
				if(mac_out[19:0] > bias[6:0]* 7'd127)
					sa_out = {mac_out[20], mac_out[19:0] - bias[6:0] * 7'd127};
				else
					sa_out = {~mac_out[20], bias[6:0] * 7'd127 - mac_out[19:0]};
			end
			else
				sa_out = {mac_out[20],  mac_out[19:0] + bias[6:0] * 7'd127};
		end
		else begin
			if((mac_out[20] ^ sa_out[20])) begin
				if(mac_out[19:0] > sa_out[19:0])
					sa_out = {mac_out[20], mac_out[19:0] - sa_out[19:0]};
				else
					sa_out = {~mac_out[20], sa_out[19:0] - mac_out[19:0]};
			end
			else
				sa_out = {mac_out[20],  mac_out[19:0] + sa_out[19:0]};
		end
	end
	
	assign ReLU_out = (sa_out[20] == 1) ? 21'b0 : sa_out[20:9];
	assign out = (ReLU_out > 21'd127) ? {1'b0, 7'b1111111} : {1'b0, ReLU_out[6 : 0]};

endmodule
