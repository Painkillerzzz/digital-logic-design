`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/24 23:10:11
// Design Name: 
// Module Name: ball_tb
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


module ball_tb;
reg clk;
reg rst;
reg [11:0] xc;
reg[11:0] yc;
reg[11:0]hdata;
reg[11:0]vdata;
reg [7:0]r;
reg [7:0]g;
reg [7:0]b;
draw_redball rdb(
    .clk(clk),
    .rst(rst),
    .xc(xc),
    .yc(yc),
    .hdata(hdata),
    .vdata(vdata),
    .video_red(r),
    .video_green(g),
    .video_blue(b)
);
initial begin
    clk = 0;
    xc = 200;
    yc = 125;
    hdata = 0;
    vdata = 0;
    forever begin
        #5 clk = ~clk;
    end
end
endmodule
