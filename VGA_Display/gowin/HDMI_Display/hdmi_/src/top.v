module top(
input clk,
input rst,
output [2:0] O_tmds_data_p,
output [2:0] O_tmds_data_n,
output tmds_clk_p,
output tmds_clk_n
);
wire clk_100Mhz,clk_25Mhz,clk_125Mhz;
wire Hsync,Vsync,De;
wire [7:0] red,green,blue;

//input 27Mhz, output 100Mhz
Gowin_rPLL pll(
.clkin(clk),
.clkout(clk_100Mhz)
);

//input 100Mhz, output 25Mhz
Gowin_CLKDIV clk_div(
.hclkin(clk_100Mhz),
.resetn(rst),
.clkout(clk_25Mhz)

);
// clk 25Mhz for pixel generation
top_display vga_top(
.clk(clk_25Mhz),
.hsync(Hsync),
.vsync(Vsync),
.r(red),
.g(green),
.b(blue),
.de(De)
);

//input 25 Mhz, output 125Mhz
Gowin_rPLL_serial serial_clk (
.clkin(clk_25Mhz),
.clkout(clk_125Mhz)
);

// 25Mhz for RGB,tmds encoding, 125 Mhz for serialization of 10 bits each R,G and B
DVI_TX_Top hdmi_top(
.I_rst_n(rst),
.I_serial_clk(clk_125Mhz),
.I_rgb_clk(clk_25Mhz),
.I_rgb_vs(Vsync),
.I_rgb_hs(Hsync),
.I_rgb_de(De),
.I_rgb_r(red),
.I_rgb_g(green),
.I_rgb_b(blue),
.O_tmds_clk_p(tmds_clk_p),
.O_tmds_clk_n(tmds_clk_n),
.O_tmds_data_p(O_tmds_data_p),
.O_tmds_data_n(O_tmds_data_n)

);

endmodule
