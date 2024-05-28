`timescale 1ns / 1ns

module tb;
reg clk;
reg rst;
reg[11:0] xc;
reg[11:0] yc;
reg[11:0] cur_x;
reg[11:0] cur_y;
reg[11:0] next_x;
reg[11:0] next_y;

initial begin
    clk = 0;
    rst = 1;
    xc = 200;
    yc = 125;
    cur_x = 120;
    cur_y = 125;
    forever begin
        #10 rst = 0;
        clk = ~clk;
        #100 cur_x = next_x;
        #100 cur_y = next_y;
    end
end

circular_motion c(
    .clk(clk),
    .reset(rst),
    .xc(xc),
    .yc(yc),
    .cur_x(cur_x),
    .cur_y(cur_y),
    .next_x(next_x),
    .next_y(next_y)
);
endmodule
