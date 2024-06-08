`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/05 18:48:30
// Design Name: 
// Module Name: page_controller
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

module page_controller(
    input wire clk,
    input wire rst,
    input wire kb_change,
    input stage_state_t stage_state,
    output page_state_t page_state
    );

    page_state_t next_state;

    always_ff @(posedge clk) begin
        if (rst) begin
            page_state <= START_PAGE; // TODO: Change to START_PAGE
        end else begin
            page_state <= next_state;
        end
    end

    always_comb begin
        casez (page_state)
            START_PAGE: begin
                if (kb_change) begin
                    next_state = STAGE_1;
                end else begin
                    next_state = START_PAGE;
                end
            end
            STAGE_1: begin
                if (kb_change && stage_state == CLEAR) begin
                    next_state = STAGE_2;
                end else if (kb_change && stage_state == FAIL) begin
                    next_state = START_PAGE;
                end else begin
                    next_state = STAGE_1;
                end
            end
            STAGE_2: begin
                if (kb_change && stage_state == CLEAR) begin
                    next_state = END_PAGE;
                end else if (kb_change && stage_state == FAIL) begin
                    next_state = START_PAGE;
                end else begin
                    next_state = STAGE_2;
                end
            end
            END_PAGE: begin
                if (kb_change) begin
                    next_state = START_PAGE;
                end else begin
                    next_state = END_PAGE;
                end
            end
            default: begin
                next_state = START_PAGE;
            end
        endcase
    end
endmodule
