`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/17 17:35:41
// Design Name: 
// Module Name: tb_get_pitch
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


`timescale 1ns/1ps

module tb_get_pitch();

    // Inputs
    reg clk;
    reg rst;

    // Outputs
    wire [5:0] pitch;

    // Instantiate the get_pitch module
    get_pitch_new uut (
        .clk(clk),
        .rst(rst),
        .pitch(pitch)
    );

    // Clock generation
    always #5 clk = ~clk; // 100 MHz clock

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;

        // Wait for global reset
        #20;
        rst = 0;

    end

endmodule

