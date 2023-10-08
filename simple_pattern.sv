`timescale 1ns / 1ps
module Simple_pattern(
	input wire clk,           // 50 MHz
	output  o_hsync,      // horizontal sync
	output  o_vsync,	     // vertical sync
	output  o_red,
	output  o_blue,
	output  o_green  
);

	reg [9:0] counter_x = 0;  // horizontal counter
	reg [9:0] counter_y = 0;  // vertical counter
	reg  r_red = 0;
	reg  r_blue = 0;
	reg  r_green = 0;
	
	reg reset = 0;  // for PLL
	
	wire clk25MHz;
		
	design_1 clk_ip(
	   .clk_in1_0(clk),
	   .clk_out1_0(clk25MHz),
	   .locked_0(),
	   .reset_0(reset)
	);

	always @(posedge clk25MHz)  // horizontal counter
		begin 
			if (counter_x < 799)
				counter_x <= counter_x + 1;  
			else
				counter_x <= 0;              
		end  // always 
	
	always @ (posedge clk25MHz)  // vertical counter
		begin 
			if (counter_x == 799) 
				begin
					if (counter_y < 525)  
						counter_y <= counter_y + 1;
					else
						counter_y <= 0;              
				end  // if (counter_x...
		end  
		
	assign o_hsync = (counter_x < 10'd96) ? 1:0;  // hsync high for 96 counts                                                 
	assign o_vsync = (counter_y < 10'd2) ? 1:0;   // vsync high for 2 counts
	
    always @ (posedge clk25MHz)
		begin
			if (counter_y < 135)
				begin              
					r_red <= 1'b1;    // white
					r_blue <= 1'b0;
					r_green <= 1'b0;
				end  
				
			else if (counter_y >= 135 && counter_y < 235)
				begin 
					r_red <= 1'b0;    // white
                    r_blue <= 1'b1;
                    r_green <= 1'b0;
				end 
				
			else if (counter_y >= 235 && counter_y < 335)
				begin 
				r_red <= 1'b1;    // white
                r_blue <= 1'b1;
                r_green <= 1'b0;
				end  
				
			else if (counter_y >= 335 && counter_y < 435)
				begin
				r_red <= 1'b0;    // white
                r_blue <= 1'b0;
                r_green <= 1'b1;
				end  
				
			else if (counter_y >= 435 && counter_y < 535)
				begin
				r_red <= 1'b1;    // white
                r_blue <= 1'b0;
                r_green <= 1'b1;	
				end 
		end 
		
    assign o_red = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_red : 1'b0;
	assign o_blue = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_blue : 1'b0;
	assign o_green = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_green : 1'b0;
	
endmodule  // VGA_image_gen