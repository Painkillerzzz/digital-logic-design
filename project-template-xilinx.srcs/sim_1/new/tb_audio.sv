`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/17 19:17:58
// Design Name: 
// Module Name: tb_audio
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

module tb_audio();

    // Inputs
    reg clk;
    reg rst;

    // Outputs
    wire audio_out;

    // Instantiate the audio module
    audio_new uut (
        .clk(clk),
        .rst(rst),
        .audio_out(audio_out)
    );

    // Clock generation using forever loop
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    initial begin
        // Initialize Inputs
        rst = 1;

        // Wait for global reset
        #20;
        rst = 0;

        // Run simulation indefinitely
        // Simulation will not stop automatically
        // Manually stop the simulation in your simulation environment
        // when you have observed enough behavior
    end

endmodule

