`timescale 1ns / 1ps
// Module to generate simple VGA pattern
module Simple_pattern(
    input wire clk25MHz,           // 25 MHz input clock signal
    output o_hsync,                // Horizontal sync signal for VGA
    output o_vsync,                // Vertical sync signal for VGA
    output [7:0]o_red,                  // Red color signal for VGA
    output [7:0]o_blue,                 // Blue color signal for VGA
    output [7:0]o_green,
    output de                 // Green color signal for VGA
);

    // Horizontal and vertical counters to track pixel positions
    reg [9:0] counter_x = 0;  // Horizontal pixel counter (X axis)
    reg [9:0] counter_y = 0;  // Vertical pixel counter (Y axis)
    
    // Registers for the color signals (red, blue, green)
    reg [7:0] r_red = 0;
    reg [7:0]r_blue = 0;
    reg [7:0]r_green = 0;
    
    // Reset signal for the PLL (not used in this code, but initialized to 0)
    reg reset = 0;

    // Horizontal pixel counter logic
    always @(posedge clk25MHz)  
    begin 
        // Increment horizontal counter until it reaches 799
        if (counter_x < 799)
            counter_x <= counter_x + 1;  
        else
            // Reset the horizontal counter after reaching 799 (end of line)
            counter_x <= 0;              
    end 

    // Vertical pixel counter logic (increments only when horizontal counter resets)
    always @ (posedge clk25MHz)  
    begin 
        // Increment vertical counter when horizontal counter reaches its max value (799)
        if (counter_x == 799) 
        begin
            if (counter_y < 525)  
                counter_y <= counter_y + 1;  // Increment vertical counter
            else
                counter_y <= 0;  // Reset vertical counter after reaching 525 (end of frame)
        end
    end  

    // Horizontal sync signal (active for first 96 counts of horizontal line)
    assign o_hsync = (counter_x < 10'd96) ? 1 : 0;  
    // Vertical sync signal (active for first 2 counts of vertical frame)
    assign o_vsync = (counter_y < 10'd2) ? 1 : 0;   

    // Color generation logic: determine pixel color based on the current position
    always @ (posedge clk25MHz)
    begin
        // Generate a black square (no color) in the center of the screen
        if (counter_y < 135)
        begin              
            r_red <= 8'b11010000;    
            r_blue <= 8'd0;
            r_green <= 8'd0;
        end  
        // Generate blue color in a strip from Y=135 to Y=235
        else if (counter_y >= 135 && counter_y < 235)
        begin 
            r_red <= 8'd0;    
            r_blue <= 8'd255;
            r_green <= 8'd0;
        end 
        // Generate magenta (red+blue) color in a strip from Y=235 to Y=335
        else if (counter_y >= 235 && counter_y < 335)
        begin 
            r_red <= 8'd255;    
            r_blue <= 8'd255;
            r_green <= 8'd0;
        end  
        // Generate green color in a strip from Y=335 to Y=435
        else if (counter_y >= 335 && counter_y < 435)
        begin
            r_red <= 8'd0;    
            r_blue <= 8'd0;
            r_green <= 8'd255;
        end  
        // Generate yellow (red+green) color in a strip from Y=435 to Y=535
        else if (counter_y >= 435 && counter_y < 535)
        begin
            r_red <= 8'd255;    
            r_blue <= 8'd0;
            r_green <= 8'd255;    
        end 
        // Default to black (no color) outside specified areas
        else
        begin
            r_red <= 8'd0; 
            r_blue <= 8'd0;
            r_green <= 8'd0;
        end 
    end 
    assign de = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514)?1:0; 
    // Output color signals only within the visible area (defined by pixel ranges)
    assign o_red = (de) ? r_red : 8'd0;
    assign o_blue = (de) ? r_blue : 8'd0;
    assign o_green = (de) ? r_green : 8'd0;

endmodule  // End of Simple_pattern module