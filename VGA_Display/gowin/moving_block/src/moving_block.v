`timescale 1ns / 1ps

module block(
    input wire clk,
    input wire rst,
    input wire [5:0] counter_x,
    input wire [5:0] counter_y,
    output reg [5:0] loc_block_x,
    output reg [5:0] loc_block_y,
    output reg draw_block
);

  parameter START_X_LOC = 3;
  parameter START_Y_LOC = 200;      // Starting Y position of the block
  parameter BLOCK_SPEED = 1250000; // Speed control
  parameter MAX_X_LOC = 35;        // Maximum X location for the block
  parameter MIN_X_LOC = 1;        // Minimum X location for the block
  parameter BLOCK_WIDTH = 4;       // Block size in both X and Y
  
  reg [31:0] block_speed_counter = 0;
  reg dir_x = 1;   // 1 for right, 0 for left
  reg [5:0] count_x = START_X_LOC;
  reg [5:0] count_y = START_Y_LOC; // Fixed Y position for now

  // Speed control
  always @(posedge clk) begin
    if (block_speed_counter == BLOCK_SPEED) begin
      block_speed_counter <= 0;
    end else begin
      block_speed_counter <= block_speed_counter + 1;
    end
  end

  // Movement logic with continuous bounce back
  always @(posedge clk or posedge rst) begin
    if (rst) begin
        count_x <= START_X_LOC;
        dir_x <= 1;  // Start moving to the right after reset
    end else if (block_speed_counter == BLOCK_SPEED) begin
        if (dir_x) begin
            count_x <= count_x + 1;
        end else begin
            count_x <= count_x - 1;
        end

        // Bounce back logic when hitting the edges
        if (count_x >= MAX_X_LOC) begin
            dir_x <= 0;  // Change direction to left
        end else if (count_x <= MIN_X_LOC) begin
            dir_x <= 1;  // Change direction to right
        end
    end
  end

  // Assign the current block position
  always @(posedge clk) begin
    loc_block_x <= count_x;
    loc_block_y <= count_y;  // Fixed vertical position (or you could add vertical motion)
  end

  // Draw a square block (100x100 pixels)
  always @(posedge clk) begin
    if (counter_x >= count_x && counter_x <= count_x + BLOCK_WIDTH &&
        counter_y >= count_y && counter_y <= count_y + BLOCK_WIDTH) begin
      draw_block <= 1'b1;
    end else begin
      draw_block <= 1'b0;
    end
  end

endmodule
