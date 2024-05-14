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
    input wire [16:0] addra,
    output wire [7:0] video_red,
    output wire [7:0] video_green,
    output wire [7:0] video_blue
    );

    blk_mem_gen_0 bg_R (
        .clka(clk_in),    // input wire clka
        .addra(addra),  // input wire [16 : 0] addra
        .douta(video_red) // output wire [7 : 0] douta
    );
    blk_mem_gen_0 bg_G (
        .clka(clk_in),    // input wire clka
        .addra(addra),  // input wire [16 : 0] addra
        .douta(video_green) // output wire [7 : 0] douta
    );
    blk_mem_gen_0 bg_B (
        .clka(clk_in),    // input wire clka
        .addra(addra),  // input wire [16 : 0] addra
        .douta(video_blue) // output wire [7 : 0] douta
    );
endmodule