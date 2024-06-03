`timescale 1ns / 1ps

module vram_rd(
    input wire clk,
    input wire rst,
    input wire[11:0] hdata,
    input wire[11:0] vdata,
    output wire ena,
    output reg[18:0] addr
);
    assign ena = 1'b1;
    always_ff @(posedge clk or posedge rst)begin
        if(rst)begin
            addr <= 0;
        end else begin
            if(hdata<800&&vdata<500)begin
                if(addr==400000-1)begin
                    addr <= 0;
                end else begin
                    addr <= addr + 1;
                end
            end else
                addr <= addr;
        end
    end


endmodule