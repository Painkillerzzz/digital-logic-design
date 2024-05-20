`timescale 1ns/1ps
module mod_top_tb();

    reg clock;
    reg reset;
    
    wire audio;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, mod_top_tb);
        clock = 1'b0;
        reset = 1'b0;

        #100;
        reset = 1'b1;

        #100;
        reset = 1'b0;

        #500000000;
        $finish;
    end

    always #5 clock = ~clock; // 100MHz

    mod_top dut(
        .clk_100m(clock),
        .btn_rst(reset),
        .beep(audio)
    );

endmodule
