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


module page_controller(
    input wire clk,
    input wire rst,
    input wire kb_change,
    input wire stage_clear,
    output reg [2:0] page_state
    );

    typedef enum logic [2:0] { 
        START_PAGE,
        STAGE_1,
        STAGE_1_CLEAR,
        STAGE_2,
        STAGE_2_CLEAR,
        STAGE_3,
        STAGE_3_CLEAR,
        END_PAGE
    } page_state_t;

    page_state_t next_state;

    always_ff @(posedge clk) begin
        if (rst) begin
            page_state <= START_PAGE;
            next_state <= START_PAGE;
        end else begin
            page_state <= next_state;
        end
    end

    always_comb begin
        case (page_state)
            START_PAGE: begin
                if (kb_change) begin
                    next_state <= STAGE_1;
                end else begin
                    next_state <= START_PAGE;
                end
            end
            STAGE_1: begin
                if (stage_clear) begin
                    next_state <= STAGE_1_CLEAR;
                end else begin
                    next_state <= STAGE_1;
                end
            end
            STAGE_1_CLEAR: begin
                if (kb_change) begin
                    next_state <= STAGE_2;
                end else begin
                    next_state <= STAGE_1_CLEAR;
                end
            end
            STAGE_2: begin
                if (stage_clear) begin
                    next_state <= STAGE_2_CLEAR;
                end else begin
                    next_state <= STAGE_2;
                end
            end
            STAGE_2_CLEAR: begin
                if (kb_change) begin
                    next_state <= STAGE_3;
                end else begin
                    next_state <= STAGE_2_CLEAR;
                end
            end
            STAGE_3: begin
                if (stage_clear) begin
                    next_state <= STAGE_3_CLEAR;
                end else begin
                    next_state <= STAGE_3;
                end
            end
            STAGE_3_CLEAR: begin
                if (kb_change) begin
                    next_state <= END_PAGE;
                end else begin
                    next_state <= STAGE_3_CLEAR;
                end
            end
            END_PAGE: begin
                if (kb_change) begin
                    next_state <= START_PAGE;
                end else begin
                    next_state <= STAGE_3_CLEAR;
                end
            end
            default: begin
                next_state <= START_PAGE;
            end
        endcase
    end
endmodule
