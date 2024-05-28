`timescale 1ns / 1ps

module vram_rd(
    input wire clk,
    input wire rst,
    input wire[11:0] hdata,
    input wire[11:0] vdata,
    output wire ena,
    output reg[16:0] addr
);
    assign ena = 1'b1;
    reg xupdate;
    reg yupdate;
    always_ff @(posedge clk or posedge rst)begin
        if(rst)begin
            addr <= 0;
            xupdate <=0;
            yupdate<=0;
        end else begin
            if(hdata<400&&vdata<250)begin
                if(addr==100000-1)begin
                    addr <= 0;
                end else begin
                    addr <= addr + 1;
                end
            end else
                addr <= addr;
        end
    end


endmodule