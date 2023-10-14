`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2023 10:26:39 PM
// Design Name: 
// Module Name: ball
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ball(
    input wire clk,
    input wire rst,
    input wire [5:0] counter_x,
    input wire [5:0] counter_y,
    output reg draw_ball
  );
  
  parameter START_X_LOC = 20;
  parameter START_Y_LOC = 15;
  parameter BALL_SPEED = 1250000;
  
  reg [31:0] ball_speed_coun = 0;
  reg       loc_x = 1;
  reg       loc_y = 1;
  reg [5:0] count_x   = START_X_LOC;
  reg [5:0] count_y   = START_Y_LOC;
  
  always@(posedge clk)
  begin
    if(ball_speed_coun == BALL_SPEED)
    begin
        ball_speed_coun <= 'b0;
    end
    else
    begin
        ball_speed_coun <= ball_speed_coun + 1;
    end
  end
  
  always@(posedge clk)
  begin
  
    if(ball_speed_coun == BALL_SPEED)
    begin
        if(loc_x)
        begin
            count_x <= count_x - 1;
        end
        else 
        begin
            count_x <= count_x + 1;
        end
        if(loc_y)
            begin
                count_y <= count_y - 1;
            end
            else 
            begin
                count_y <= count_y + 1;
            end
    end
  end
  
  always@(*)
  begin
      if(count_x == 10'd36)
      begin
          loc_x = 1;
      end
      else if (count_x == 10'd2)
      begin
          loc_x = 0;
      end
    
      if(count_y == 10'd27)
      begin
          loc_y = 1;
      end
      else if (count_y == 10'd6)
      begin
          loc_y = 0;
      end
  end
    
  always@(posedge clk)
  begin
    if(counter_x >= count_x && (counter_x <= count_x + 1) && counter_y >= count_y && (counter_y <= count_y + 1))
    begin
        draw_ball <= 1'b1;
    end
    else
    begin
        draw_ball <= 1'b0;
    end
  end
  
endmodule
