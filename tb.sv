`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2023 04:01:03 PM
// Design Name: 
// Module Name: tb
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


module tb(
    );

logic clk;

always@(*) begin
    forever begin
        clk = ~clk;
        #5;
    end
    end

    Simple_pattern u_Simple_pattern(
        .clk(clk),
        .o_hsync(),
        .o_vsync(),
        .o_red(),
        .o_green(),
        .o_blue()
    );
    
    initial begin
        clk = 0;
        #100000000;
        $finish();
    end

endmodule
