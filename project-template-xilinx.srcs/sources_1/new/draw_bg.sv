`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/14 14:27:31
// Design Name: 
// Module Name: draw_bg
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


module draw_bg(
    input wire clk_in,
    input wire [11:0] hdata,
    input wire [11:0] vdata,
    output wire [7:0] video_red,
    output wire [7:0] video_green,
    output wire [7:0] video_blue
    );

    wire [11:0]x;
    wire [11:0]y;
    wire [16:0] addra;
    assign x = hdata[11:1];
    assign y = vdata[11:1];
    assign addra = x + y*400;
    blk_mem_gen_0 bg_R (
        .clka(clk_in),    // input  wire clka
        .addra(addra),    // input  wire [16:0] addra
        .douta(video_red) // output wire [7:0] douta
    );
    blk_mem_gen_1 bg_G (
        .clka(clk_in),      // input  wire clka
        .addra(addra),      // input  wire [16:0] addra
        .douta(video_green) // output wire [7:0] douta
    );
    blk_mem_gen_2 bg_B (
        .clka(clk_in),     // input  wire clka
        .addra(addra),     // input  wire [16:0] addra
        .douta(video_blue) // output wire [7:0] douta
    );
endmodule