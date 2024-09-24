`timescale 1ns / 1ps

module top(
	input        clk,          
    input        uart_rx,
    input        btn1,
    output       uart_tx,
	output       o_hsync,     
	output       o_vsync,	     
	output       o_red,
	output       o_blue,
	output       o_green,
    output [5:0] led
);

    reg [9:0] counter_x = 0;  
	reg [9:0] counter_y = 0;  
	reg [9:0] counter_x_dim = 0;
	reg [9:0] counter_y_dim = 0;
	reg  r_red = 0;
	reg  r_blue = 0;
	reg  r_green = 0;

    wire rst;
	wire [5:0] counter_x_div;
	wire [5:0] counter_y_div;  
    wire [5:0] loc_block_x;
    wire [5:0] loc_block_y;    
	wire draw_block;

	wire clk100Mhz;
	wire clk25MHz;
		
    Gowin_rPLL u_Gowin_rPLL
    (
        .clkout(clk100Mhz), 
        .clkin(clk)
    );
	
    Gowin_CLKDIV u_Gowin_CLKDIV
    (
        .clkout(clk25MHz), 
        .hclkin(clk100Mhz), 
        .resetn(1'b1)
    );

    // Instantiate the block module
    block u_block (
        .clk(clk25MHz),
        .rst(rst),
        .counter_x(counter_x_div),
        .counter_y(counter_y_div),  
        .loc_block_x(loc_block_x),
        .loc_block_y(loc_block_y),  
        .draw_block(draw_block)
    );

	// Horizontal counter (799 total pixels)
	always @(posedge clk25MHz) begin 
		if (counter_x < 799) begin
			counter_x <= counter_x + 1; 
			if (counter_x > 10'd144 && counter_x <= 10'd783) begin
			    counter_x_dim <= counter_x_dim + 1;
			end else begin
			    counter_x_dim <= 0;
			end
		end else begin
			counter_x <= 0;              
		end
	end 
	
	// Vertical counter (525 total pixels)
	always @(posedge clk25MHz) begin 
		if (counter_x == 799) begin
			if (counter_y < 525) begin
			    counter_y <= counter_y + 1;
				if (counter_y > 10'd35 && counter_y <= 514) begin
				  counter_y_dim <= counter_y_dim + 1;
				end else begin
				  counter_y_dim <= 0;
				end
			end else begin
			  counter_y <= 0;
			end
		end             
	end  
		
	assign o_hsync = (counter_x < 10'd96) ? 1:0;  // Horizontal sync                                            
	assign o_vsync = (counter_y < 10'd2) ? 1:0;   // Vertical sync
	
	// Set the background to white and block to red
	always @(posedge clk25MHz) begin
		if (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) begin
		    if (draw_block) begin
			    r_red <= 1'b1;     // Draw block in red
                r_blue <= 1'b0;
                r_green <= 1'b0;
			end else begin
			    r_red <= 1'b1;     // Background is white (R, G, B all high)
                r_blue <= 1'b1;
                r_green <= 1'b1;
			end
		end else begin
		    r_red <= 1'b0;
		    r_blue <= 1'b0;
		    r_green <= 1'b0;
		end
	end
	
	assign counter_x_div = counter_x_dim[9:4];	
	assign counter_y_div = counter_y_dim[9:4];  

	assign o_red   = r_red;
	assign o_blue  = r_blue;
	assign o_green = r_green;
	
endmodule
