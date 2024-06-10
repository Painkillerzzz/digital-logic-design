`timescale 1ns / 1ps

import namespace::*;

module check_hit #(
    parameter INTERVAL = 3_960_000, // check interval length / HEALTH_DE
              TOTAL_HEALTH = 100,
              HEALTH_DE = 5
) (
    input wire clk,
    input wire rst,
    input wire scancode_change,
    input wire check_en,
    input page_state_t page_state,
    input stage_state_t stage_state,
    output reg [8:0] health,
    output reg [1:0] death_cause,
    output reg hit_cnt
);

    typedef enum logic [1:0]{ 
        IDLE,
        DOWN,
        UP
    } state_t;

    // reg hit_cnt;
    reg [7:0] health_decrease;
    reg [31:0] bias_cnt;
    reg decreased;

    state_t current_state, next_state;
    page_state_t last_page_stage;
    
    // State machine
    always_ff @(posedge clk) begin
        if (rst) begin
            current_state <= IDLE;
            next_state <= IDLE;
        end else begin
            current_state <= next_state;
            case (current_state)
                IDLE: begin
                    if (check_en) begin
                        next_state <= DOWN;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                DOWN: begin
                    if (health_decrease <= 0) begin
                        next_state <= UP;
                    end else begin
                        next_state <= DOWN;
                    end
                end
                UP: begin
                    if (!check_en) begin
                        next_state <= IDLE;
                    end else begin
                        next_state <= UP;
                    end
                end
            endcase
        end
    end

    // State machine
    always_ff @(posedge clk) begin
        if (rst) begin
            hit_cnt <= 0;
            health <= TOTAL_HEALTH;
            health_decrease <= 0;
            death_cause <= 0;
            decreased <= 0;
            last_page_stage <= START_PAGE;
        end else if (last_page_stage != page_state) begin
            hit_cnt <= 0;
            health <= TOTAL_HEALTH;
            health_decrease <= 0;
            death_cause <= 0;
            decreased <= 0;
            last_page_stage <= page_state;
        end else begin
            case (current_state)
                IDLE: begin
                    hit_cnt <= 0;
                    health_decrease <= HEALTH_DE;
                    decreased <= 0;
                    if(scancode_change && stage_state == EXECUTING) begin
                        death_cause <= 1;
                        health <= 0;
                    end
                end
                DOWN: begin
                    if(scancode_change) begin
                        if(hit_cnt == 0) begin
                            hit_cnt <= 1;
                            if(!decreased) begin
                                decreased <= 1;
                                health <= health - health_decrease;
                            end
                        end else begin
                            death_cause <= 2;
                            health <= 0;
                        end
                    end
                    if(bias_cnt == INTERVAL - 1) begin
                        health_decrease <= health_decrease - 1;
                    end else begin
                        health_decrease <= health_decrease;
                    end
                end
                UP: begin
                    if (!check_en) begin
                        if(hit_cnt == 0) begin
                            death_cause <= 3;
                            health <= 0;
                        end
                        // interval_cnt <= 0;
                    end else begin
                        if(scancode_change) begin
                            if(hit_cnt == 1) begin
                                hit_cnt <= 1;
                                if(!decreased) begin
                                    decreased <= 1;
                                    health <= health - health_decrease;
                                end
                            end else begin
                                death_cause <= 2;
                                health <= 0;
                            end
                        end
                        if(bias_cnt == INTERVAL - 1) begin
                            health_decrease <= health_decrease + 1;
                        end else begin
                            health_decrease <= health_decrease;
                        end
                    end
                end
            endcase
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            bias_cnt <= 0;
        end else if (check_en) begin
            if(bias_cnt == INTERVAL - 1) begin
                bias_cnt <= 0;
            end else begin
                bias_cnt <= bias_cnt + 1;
            end
        end else begin
            bias_cnt <= 0;
        end
    end
endmodule