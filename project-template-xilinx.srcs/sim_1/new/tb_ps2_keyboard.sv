`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/02 03:37:39
// Design Name: 
// Module Name: tb_ps2_keyboard
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


module ps2_keyboard_tb;

    // Testbench signals
    reg clock;
    reg reset;
    reg ps2_clock;
    reg ps2_data;
    wire [7:0] scancode;
    wire valid;
    wire change;

    // Instantiate the ps2_keyboard module
    ps2_keyboard uut (
        .clock(clock),
        .reset(reset),
        .ps2_clock(ps2_clock),
        .ps2_data(ps2_data),
        .scancode(scancode),
        .valid(valid),
        .change(change)
    );

    // Clock generation
    always #5 clock = ~clock;

    // PS2 clock generation (slowed down for better visibility)
    initial begin
        ps2_clock = 1'b1;
        forever #50 ps2_clock = ~ps2_clock; // 100ns period
    end

    // Task to send a PS2 code
    task send_ps2_code(input [7:0] code);
        integer i;
        reg parity;
        begin
            parity = ^code;

            // Start bit
            ps2_data = 1'b0;
            @(negedge ps2_clock);

            // Data bits
            for (i = 0; i < 8; i = i + 1) begin
                ps2_data = code[i];
                @(negedge ps2_clock);
            end

            // Parity bit
            ps2_data = parity;
            @(negedge ps2_clock);

            // Stop bit
            ps2_data = 1'b1;
            @(negedge ps2_clock);
        end
    endtask

    initial begin
        // Initialize signals
        clock = 0;
        reset = 0;
        ps2_data = 1'b1;

        // Apply reset
        reset = 1;
        #100;
        reset = 0;

        // Wait for a while after reset
        #1000;

        // Send first PS2 code (e.g., 8'h1C)
        send_ps2_code(8'h1C);
        #2000;

        // Send second PS2 code (e.g., 8'h1D)
        send_ps2_code(8'h1D);
        #2000;

        // Send third PS2 code (e.g., 8'h1E)
        send_ps2_code(8'h1E);
        #2000;

        // Finish simulation
        $finish;
    end

    initial begin
        // Monitor changes
        $monitor("Time=%0t, clock=%b, reset=%b, ps2_clock=%b, ps2_data=%b, scancode=%h, valid=%b, change=%b", 
                  $time, clock, reset, ps2_clock, ps2_data, scancode, valid, change);
    end

endmodule
