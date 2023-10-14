`timescale 1ns / 1ps
module Simple_pattern(
	input wire clk,          
	input wire button1,
	input wire button2,
	input wire button3,
	input wire button4,
	output  o_hsync,     
	output  o_vsync,	     
	output  o_red,
	output  o_blue,
	output  o_green  
);

    parameter X_LOC_P1 = 1;
    parameter X_LOC_P2 = 37;
    
    parameter START_Y_LOC_F1 = 0;
    parameter END_Y_LOC_F1 = 13;
    parameter START_X_LOC_F1 = 1;
    parameter END_X_LOC_F1 = 160;
    
    parameter START_Y_LOC_F2 = 14;
    parameter END_Y_LOC_F2 = 21;
    parameter START_X_LOC_F2 = 1;
    parameter END_X_LOC_F2 = 160;
    
    parameter START_Y_LOC_F3 = 21;
    parameter END_Y_LOC_F3 = 119;
    parameter START_X_LOC_F3 = 1;
    parameter END_X_LOC_F3 = 160;

	reg [9:0] counter_x = 0;  
	reg [9:0] counter_y = 0;  
	reg [9:0] counter_x_dim = 0;
	reg [9:0] counter_y_dim = 0;
	reg  r_red = 0;
	reg  r_blue = 0;
	reg  r_green = 0;
	
	wire [5:0] counter_x_div;
	wire [5:0] counter_y_div;
	wire draw_padle1, draw_padle2;
	wire draw_ball,draw_frame_f1,draw_frame_f2,draw_frame_f3;
	
	reg reset = 0; 
	
	wire clk25MHz;
		
	design_1 clk_ip(
	   .clk_in1_0(clk),
	   .clk_out1_0(clk25MHz),
	   .locked_0(),
	   .reset_0(reset)
	);
	
	paddle #
	(
	   .X_LOC(X_LOC_P1)
	)
	u_paddle1 (
	   .clk(clk25MHz),
	   .rst(reset),
	   .btn1(button1),
	   .btn2(button2),
	   .counter_x(counter_x_div),
	   .counter_y(counter_y_div),
	   .draw_padle(draw_padle1)
	);
	
	paddle #
    (
       .X_LOC(X_LOC_P2)
    )
    u_paddle2 (
       .clk(clk25MHz),
       .rst(reset),
       .btn1(button3),
       .btn2(button4),
       .counter_x(counter_x_div),
       .counter_y(counter_y_div),
       .draw_padle(draw_padle2)
    );
    
    ball #
    (
    )
    u_ball (
        .clk(clk25MHz),
        .rst(reset),
        .counter_x(counter_x_div),
        .counter_y(counter_y_div),
        .draw_ball(draw_ball)
    );
    
    text #
    (
        .START_Y_LOC(START_Y_LOC_F1),
        .END_Y_LOC(END_Y_LOC_F1),
        .START_X_LOC(START_X_LOC_F1),
        .END_X_LOC(END_X_LOC_F1)
    )
    u_text (
        .clk(clk25MHz),
        .rst(reset),
        .counter_x(counter_x_dim),
        .counter_y(counter_y_dim),
        .draw_frame(draw_frame_f1)
    );
    
    frame #
    (
        .START_Y_LOC(START_Y_LOC_F2),
        .END_Y_LOC(END_Y_LOC_F2),
        .START_X_LOC(START_X_LOC_F2),
        .END_X_LOC(END_X_LOC_F2)
    )
    u_frame2 (
        .clk(clk25MHz),
        .rst(reset),
        .counter_x(counter_x_dim),
        .counter_y(counter_y_dim),
        .draw_frame(draw_frame_f2)
    );
    
    frame #
    (
        .START_Y_LOC(START_Y_LOC_F3),
        .END_Y_LOC(END_Y_LOC_F3),
        .START_X_LOC(START_X_LOC_F3),
        .END_X_LOC(END_X_LOC_F3)
    )
    u_frame3 (
        .clk(clk25MHz),
        .rst(reset),
        .counter_x(counter_x_dim),
        .counter_y(counter_y_dim),
        .draw_frame(draw_frame_f3)
    );

	always @(posedge clk25MHz)  
		begin 
			if (counter_x < 799)
			begin
				counter_x <= counter_x + 1; 
				if(counter_x > 10'd144 && counter_x <= 10'd783)
				begin
				    counter_x_dim <= counter_x_dim + 1;
				end
				else
				begin
				    counter_x_dim <= 'b0;
				end
			end 
			else
				counter_x <= 0;              
		end  // always 
	
	always @ (posedge clk25MHz)
		begin 
			if (counter_x == 799) 
				begin
				if (counter_y < 525)  
				begin
				    counter_y <= counter_y + 1;
					if(counter_y > 10'd35 && counter_y <= 10'd514)
					begin
					  counter_y_dim <= counter_y_dim + 1;
					end
					else 
					begin
					  counter_y_dim <= 'b0;
					end
				end
			    else
			    begin
			      counter_y <= 0;
			    end 
			end             
		end  
		
	assign o_hsync = (counter_x < 10'd96) ? 1:0;                                            
	assign o_vsync = (counter_y < 10'd2) ? 1:0;  
	
    always @ (posedge clk25MHz)
		begin
			if (counter_y < 135)
				begin    
				    if(counter_x <= 244)   
				    begin       
					   r_red <= 1'b1;    
					   r_blue <= 1'b0;
					   r_green <= 1'b0;
					end
					else 
					begin
				        r_red <= 1'b0;  
                        r_blue <= 1'b0;
                        r_green <= 1'b0;					
					end
				end  
				else
				begin
				    r_red <= 1'b0; 
                    r_blue <= 1'b0;
                    r_green <= 1'b0;
				end 
		end 
		
	assign counter_x_div = counter_x_dim[9:4];	
	assign counter_y_div = counter_y_dim[9:4];	
		
    assign o_red = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? (draw_padle1 | draw_padle2 | draw_ball | draw_frame_f1 | draw_frame_f2 | draw_frame_f3) : 1'b0;
	assign o_blue = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? (draw_padle1 | draw_padle2 | draw_ball | draw_frame_f1 | draw_frame_f2 | draw_frame_f3) : 1'b0;
	assign o_green = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? (draw_padle1 | draw_padle2 | draw_ball | draw_frame_f1 | draw_frame_f2 | draw_frame_f3) : 1'b0;
	
endmodule