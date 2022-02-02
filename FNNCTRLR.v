`timescale  1ns/1ns
module Controller(input clk, rst,output reg done, sel, mem_read,ld, second,
	output reg[2:0] counter_8,output reg [1:0] win,output reg [3:0]ld_hlo, output  [9:0] counter1,output reg[1:0] counter_4);
  
    parameter[3:0] calc0 = 4'b0000, calc8 = 4'b0001, calc16 = 4'b0010, calc24 = 4'b0011 ,calc_out0 = 4'b0100,
	 calc_out8 = 4'b0101, counter_s = 4'b0110, END = 4'b0111, stop = 4'b1000, stop1 = 4'b1010, stop3 = 4'b1011;

    reg [3:0] ps, ns;

    reg count_up, cout, count_up8, count_up4, ldz, cout1, cout2, cout4;

    reg[9:0] counter;
    assign counter1 = counter;

    initial begin
        counter <= 10'b0;
	counter_8 <= 3'b0;
	counter_4 <= 2'b0;
    end
    
    always@(posedge clk)begin
	if(count_up4)
	    counter_4 <= counter_4 + 1;
        if(count_up)
            counter <= counter + 1;
	if(count_up8)
	    counter_8 <= counter_8 + cout4;
	else if(ldz)
	    counter_8 <= 3'b0;
    end

    assign cout = (counter >= 10'd750) ? 1'b1 : 1'b0;
    assign cout1 = (counter_8 == 3'b111) ? 1'b1 : 1'b0;
    assign cout2 = (counter_8 >= 3'd3) ? 1 : 0;

    assign cout4 = (counter_4 >= 2'b11) ? 1 : 0;


    always @(ps, cout, cout1, cout2, cout4)
    begin
        case(ps)
            calc0: ns = (cout1 && cout4) ? calc8 : calc0;
            calc8: ns = (cout1 && cout4) ? calc16 : calc8;
            calc16: ns = (cout1 && cout4) ? calc24 : calc16;
            calc24: ns = (cout1 && cout4) ? stop : calc24;
	    stop: ns = calc_out0;
            calc_out0: ns = (cout2&& cout4) ? stop3 : calc_out0;
	    stop3: ns = calc_out8;
            calc_out8: ns = (cout2&& cout4) ? stop1 : calc_out8;
            counter_s: ns = cout ? END : calc0;
	    stop1: ns = counter_s;
	    END: ns = END;
	    default: ns = calc0;
        endcase
    end

    always @(ps)  begin  
	{sel, win, ld_hlo, ld, ldz, mem_read, done, count_up, count_up8, count_up4} = 0;
	case(ps) 
	calc0: begin
            mem_read = 1'b1;
	    sel = 1'b0;
            win = 2'b00; 
	    count_up8 = 1'b1;
	    ld_hlo[0] = 1'b1;
	    count_up4 = 1'b1;
	end
	calc8:begin
	    mem_read = 1'b1;
	    sel = 1'b0;
            win = 2'b01;
	    count_up4 = 1'b1;
	    ld_hlo[1] = 1'b1;
	    count_up8 = 1'b1;
	end
	calc16:begin
	    mem_read = 1'b1;
	    sel = 1'b0;
            win = 2'b10;
	    ld_hlo[2] = 1'b1;
	    count_up8 = 1'b1;
	    count_up4 = 1'b1;
        end
	calc24: begin
	    mem_read = 1'b1;
	    sel = 1'b0;
            win = 2'b11;
            ld_hlo[3] = 1'b1;
	    count_up8 = 1'b1;
	    count_up4 = 1'b1;
	end
	stop: begin
	    ld = 1'b1;
	    ldz = 1'b1;
	end
	calc_out0: begin
	    sel = 1'b1;
            win = 2'b00;
	    count_up4 = 1'b1;
	    count_up8 = 1'b1;
	    ld_hlo[0] = 1'b1;
	end
	stop3:
	    ldz = 1'b1;
	calc_out8: begin
	    second = 1'b1;
	    sel = 1'b1;
            win = 2'b01;
            ld_hlo[1] = 1'b1;
	    count_up8 = 1'b1;
	    count_up4 = 1'b1;
	end
	END: begin
	    done = 1'b1;
	end	
	counter_s: begin
	    ldz = 1'b1; 
	end
	stop1: begin
	    count_up = 1'b1;
	end 
	endcase
    end

    always @(posedge clk, posedge rst)
    begin
        if (rst)
            ps <= 3'd0;
        else
            ps <= ns;
    end 
endmodule
