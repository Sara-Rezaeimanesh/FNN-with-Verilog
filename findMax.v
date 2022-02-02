`timescale 1ns/1ns
module find_max(input[79:0] arr, output reg[3:0] max_value);

    wire[7:0] in[0:9];
    assign in[0] = arr[7:0];
    assign in[1] = arr[15:8];
    assign in[2] = arr[23:16];
    assign in[3] = arr[31:24];
    assign in[4] = arr[39:32];
    assign in[5] = arr[47:40];
    assign in[6] = arr[55:48];
    assign in[7] = arr[63:56];
    assign in[8] = arr[71:64];
    assign in[9] = arr[79:72];
    
    always @(*)
    begin
        if (in[0] >= in[1] && in[0] >= in[2] && in[0] >= in[3] && in[0] >= in[4] &&
  		 in[0] >= in[5] && in[0] >= in[6] && in[0] >= in[7] && in[0] >= in[8] && in[0] >= in[9])
            max_value = 4'b0000;
        else
        if (in[1] >= in[0] && in[1] >= in[2] && in[1] >= in[3] && in[1] >= in[4] &&
  		 in[1] >= in[5] && in[1] >= in[6] && in[1] >= in[7] && in[1] >= in[8] && in[1] >= in[9])
            max_value = 4'b0001;
        else
        if (in[2] >= in[0] && in[2] >= in[1] && in[2] >= in[3] && in[2] >= in[4] &&
  		 in[2] >= in[5] && in[2] >= in[6] && in[2] >= in[7] && in[2] >= in[8] && in[2] >= in[9])
            max_value = 4'b0010;
        else

        if (in[3] >= in[0] && in[3] >= in[1] && in[3] >= in[2] && in[3] >= in[4] &&
  		 in[3] >= in[5] && in[3] >= in[6] && in[3] >= in[7] && in[3] >= in[8] && in[3] >= in[9])
            max_value = 4'b0011;
        else

        if (in[4] >= in[0] && in[4] >= in[1] && in[4] >= in[2] && in[4] >= in[3] &&
  		 in[4] >= in[5] && in[4] >= in[6] && in[4] >= in[7] && in[4] >= in[8] && in[4] >= in[9])
            max_value = 4'b0100;

        else
        if (in[5] >= in[0] && in[5] >= in[1] && in[5] >= in[2] && in[5] >= in[3] &&
  		 in[5] >= in[4] && in[5] >= in[6] && in[5] >= in[7] && in[5] >= in[8] && in[5] >= in[9])
            max_value = 4'b0101;

        else
        if (in[6] >= in[0] && in[6] >= in[1] && in[6] >= in[2] && in[6] >= in[3] &&
  		 in[6] >= in[4] && in[6] >= in[5] && in[6] >= in[7] && in[6] >= in[8] && in[6] >= in[9])
            max_value = 4'b0110;

        else
        if (in[7] >= in[0] && in[7] >= in[1] && in[7] >= in[2] && in[7] >= in[3] &&
  		 in[7] >= in[4] && in[7] >= in[5] && in[7] >= in[6] && in[7] >= in[8] && in[7] >= in[9])
            max_value = 4'b0111;

        else
        if (in[8] >= in[0] && in[8] >= in[1] && in[8] >= in[2] && in[8] >= in[3] &&
  		 in[8] >= in[4] && in[8] >= in[5] && in[8] >= in[6] && in[8] >= in[7] && in[8] >= in[9])
            max_value = 4'b1000;

        else
        if (in[9] >= in[0] && in[9] >= in[1] && in[9] >= in[2] && in[9] >= in[3] &&
  		 in[9] >= in[4] && in[9] >= in[5] && in[9] >= in[6] && in[9] >= in[7] && in[9] >= in[8])
            max_value = 4'b1001;
    end

endmodule