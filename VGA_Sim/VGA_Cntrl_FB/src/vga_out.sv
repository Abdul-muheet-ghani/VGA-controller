module vga_out #(parameter CORDW=10) (  // coordinate width
    input  wire logic clk,             // pixel clock
    input  wire logic sim_rst,             // sim reset
    output      logic [CORDW-1:0] counter_x,  // horizontal SDL position
    output      logic [CORDW-1:0] counter_y,  // vertical SDL position
    output      logic sdl_de,              // data enable (low in blanking interval)
    output      logic [7:0] red_o,         // 8-bit red
    output      logic [7:0] green_o,         // 8-bit green
    output      logic [7:0] blue_o          // 8-bit blue
    );

    // horizontal timings
    parameter HA_END = 639;           // end of active pixels
    parameter HS_STA = HA_END + 16;   // sync starts after front porch
    parameter HS_END = HS_STA + 96;   // sync ends
    parameter LINE   = 799;           // last pixel on line (after back porch)

    // vertical timings
    parameter VA_END = 479;           // end of active pixels
    parameter VS_STA = VA_END + 10;   // sync starts after front porch
    parameter VS_END = VS_STA + 2;    // sync ends
    parameter SCREEN = 524;           // last line on screen (after back porch)

	// display sync signals and coordinates
    logic [CORDW-1:0] sx, sy;
    logic de,hsync,vsync;

    always_comb begin
        hsync = (sx >= HS_STA && sx < HS_END);  // invert: negative polarity
        vsync = (sy >= VS_STA && sy < VS_END);  // invert: negative polarity
        de = (sx <= HA_END && sy <= VA_END);
    end

    // calculate horizontal and vertical screen position
    always_ff @(posedge clk) begin
        if (sx == LINE) begin  // last pixel on line?
            sx <= 0;
            sy <= (sy == SCREEN) ? 0 : sy + 1;  // last line on screen?
        end else begin
            sx <= sx + 1;
        end
        if (sim_rst) begin
            sx <= 0;
            sy <= 0;
        end
    end

    // define a square with screen coordinates
    logic square;
    always_comb begin
        square = (sx > 220 && sx < 420) && (sy > 140 && sy < 340);
    end

    // paint colour: white inside square, blue outside
    logic [3:0] paint_r, paint_g, paint_b;
    always_comb begin
        paint_r = (square) ? 4'hF : 4'h1;
        paint_g = (square) ? 4'hF : 4'h3;
        paint_b = (square) ? 4'hF : 4'h7;
    end

    // display colour: paint colour but black in blanking interval
    logic [3:0] display_r, display_g, display_b;
    always_comb begin
        display_r = (de) ? paint_r : 4'h0;
        display_g = (de) ? paint_g : 4'h0;
        display_b = (de) ? paint_b : 4'h0;
    end

    // SDL output (8 bits per colour channel)
    always_ff @(posedge clk) begin
        counter_x <= sx;
        counter_y <= sy;
        sdl_de <= de;
        red_o <=   {2{display_r}};  // double signal width from 4 to 8 bits
        green_o <= {2{display_g}};
        blue_o <=  {2{display_b}};
    end
endmodule