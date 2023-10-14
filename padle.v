`timescale 1ns / 1ps

module paddle 
#(
    parameter X_LOC = 0
)(
    input wire clk,
    input wire rst,
    input wire btn1,
    input wire btn2,
    input wire [5:0] counter_x,
    input wire [5:0] counter_y,
    output reg draw_padle
    );
    
    localparam PADLE_HIEGHT = 6;
    localparam PADLE_SPEED = 1250000;
    
    reg [31:0] speed_counter = 0;
    reg [5:0] location_y = 6;
    
    always@ (posedge clk)
    begin
        if(speed_counter == PADLE_SPEED)
        begin
            speed_counter <= 'd0;
        end
        else
        begin
            speed_counter <= speed_counter + 1;
        end
    end
    
    always@(posedge clk)
    begin
        if(btn1 == 1'b1 && speed_counter == PADLE_SPEED && (location_y < 6'd28 - PADLE_HIEGHT))
        begin
            location_y <= location_y + 1;
        end
        else if(btn2 == 1'b1 && speed_counter == PADLE_SPEED && location_y > 6'd6)
        begin
            location_y <= location_y - 1;
        end
    end
    
    always@(posedge clk)
    begin
        if(counter_x >= X_LOC && counter_x <= X_LOC + 6'd1 && counter_y >= location_y && counter_y <= PADLE_HIEGHT + location_y)
        begin
            draw_padle <= 1'b1;
        end
        else
        begin
            draw_padle <= 1'b0;
        end
    end
    
endmodule
