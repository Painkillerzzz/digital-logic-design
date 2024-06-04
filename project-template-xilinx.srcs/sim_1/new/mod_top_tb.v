`timescale 1ns/1ps
module mod_top_tb();

    reg clock;
    reg reset;
    reg ps2_clock;
    reg ps2_data;
    
    wire audio;

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
        $dumpfile("dump.vcd");
        $dumpvars(0, mod_top_tb);
        clock = 1'b0;
        reset = 1'b0;

        #100;
        reset = 1'b1;

        #100;
        reset = 1'b0;
        #199000;

        // Send first PS2 code (e.g., 8'h1C)
        send_ps2_code(8'h1C);

        #500000000;
        $finish;
    end

    always #1 clock = ~clock; // 100MHz

    mod_top dut(
        .clk_100m(clock),
        .btn_rst(reset),
        .ps2_keyboard_clk(ps2_clock),
        .ps2_keyboard_data(ps2_data),
        .beep(audio)
    );

endmodule
