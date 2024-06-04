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

module tb_check_hit();

    // Inputs
    reg clk;
    reg rst;
    reg check_en;
    reg [7:0] scancode;
    reg [7:0] last_scancode;

    // Outputs
    wire [23:0] number;
    

    // Instantiate the audio module
    check_hit #(
        100
    ) u_check_hit (
        .clk(clk),
        .rst(rst),
        .last_scancode(last_scancode),
        .scancode(scancode),
        .check_en(check_en),
        .health(number)
    );

    // Clock generation using forever loop
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    initial begin
        rst = 1;
        #20;
        rst = 0;
    end
    
    initial begin
        check_en = 0;
        #20;
        check_en = 1;
        forever begin #2000 check_en = ~check_en; end
    end

    initial begin
        scancode = 8'b0;
        last_scancode = 8'b0;
        forever
        begin
            #1000;
            scancode = ~scancode;
            #10;
            last_scancode = scancode;
            #2990;
        end
    end

endmodule

