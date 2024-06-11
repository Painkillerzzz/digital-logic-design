`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/08 13:16:52
// Design Name: 
// Module Name: tb_compute-pos
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

import namespace::*;

module tb_compute_pos;

    // Inputs
    reg clk;
    reg rst;
    reg kb_change;
    stage_state_t stage_state;
    page_state_t page_state;

    // Outputs
    pos xc;
    pos yc;
    pos blue_xc;
    pos blue_yc;
    pos red_xc;
    pos red_yc;

    // Instantiate the Unit Under Test (UUT)
    compute_pos uut (
        .clk(clk), 
        .rst(rst), 
        .kb_change(kb_change), 
        .stage_state(stage_state), 
        .page_state(page_state), 
        .xc(xc), 
        .yc(yc), 
        .blue_xc(blue_xc), 
        .blue_yc(blue_yc), 
        .red_xc(red_xc), 
        .red_yc(red_yc)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    // Stimulus process
    initial begin
        // Initialize Inputs
        rst = 1;
        kb_change = 0;
        stage_state = EXECUTING;
        page_state = STAGE_2;

        // Wait 100 ns for global reset to finish
        #100;
        
        // Deassert reset
        rst = 0;

        // Simulate kb_change
        #95;
        kb_change = 1;
        #10;
        kb_change = 0;

        // Wait for some time
        #500;

        // Simulate another kb_change
        kb_change = 1;
        #10;
        kb_change = 0;

        // Wait for the trajectory counter to update
        #100000;
        
        // Finish simulation
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("At time %t, xc = %d, yc = %d, blue_xc = %d, blue_yc = %d, red_xc = %d, red_yc = %d", 
                 $time, xc, yc, blue_xc, blue_yc, red_xc, red_yc);
    end

endmodule
