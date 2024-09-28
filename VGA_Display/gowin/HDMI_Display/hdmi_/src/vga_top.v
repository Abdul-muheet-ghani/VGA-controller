// Top-level module for displaying a pattern on the VGA output
module top_display(

    input  clk,              // System clock input (typically 27 MHz)
    output reg hsync,        // Horizontal sync output for VGA
    output reg vsync,        // Vertical sync output for VGA
    output reg [7:0] r,            // Red color signal output for VGA
    output reg[7:0] g,            // Green color signal output for VGA
    output reg[7:0] b,            // Blue color signal output for VGA
    output reg de             
);

    // Internal wire declarations
    wire o_hsync;            // Horizontal sync signal from Simple_pattern module
    wire o_vsync;            // Vertical sync signal from Simple_pattern module
    wire clk_out;  // Clock outputs from PLL and clock divider
    wire [7:0] red, green, blue;  // Color signals from Simple_pattern module
    wire d_en;

    // Unused signals for ball location and drawing (can be used in future extensions)
    wire [5:0] loc_ball_x;   // X-coordinate of the ball (not used here)
    wire [5:0] loc_ball_y;   // Y-coordinate of the ball (not used here)
    wire draw_ball;          // Signal to determine if the ball should be drawn (not used here)

    // Always block to update VGA output signals based on internal signals
    always@(*) begin
        r = red;             // Assign red color signal to VGA red output
        g = green;           // Assign green color signal to VGA green output
        b = blue;            // Assign blue color signal to VGA blue output
        hsync = o_hsync;     // Assign horizontal sync signal to VGA hsync output
        vsync = o_vsync;     // Assign vertical sync signal to VGA vsync output
        de=d_en;             
    end

  
  
    // Instantiate the Simple_pattern module to generate VGA signals
    Simple_pattern top(
        .clk25MHz(clk),  // Input clock signal (25 MHz for VGA timing)
        .o_hsync(o_hsync),    // Output horizontal sync signal
        .o_vsync(o_vsync),    // Output vertical sync signal
        .o_red(red),          // Output red color signal (8 bits)
        .o_green(green),      // Output green color signal (8 bits)
        .o_blue(blue),         // Output blue color signal (8 bits)
        .de(d_en)             // Output data_enable for display area
    );

endmodule
