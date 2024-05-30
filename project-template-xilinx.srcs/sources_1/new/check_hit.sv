module check_hit #(
    parameter INTERVAL = 10_000_000, // 0.2s
              TOTAL_HEALTH = 100
) (
    input wire clk,
    input wire rst,
    input wire [7:0] last_scancode,
    input wire [7:0] scancode,
    input wire check_en,
    output reg [7:0] health
);

    typedef enum logic [1:0]{ 
        IDLE,
        DOWN,
        UP
    } state_t;

    reg hit_cnt;
    reg [23:0] interval_cnt;

    state_t current_state, next_state;
    
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
                    if (interval_cnt <= 0) begin
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
            interval_cnt <= 0;
        end else begin
            case (current_state)
                IDLE: begin
                    if (check_en) begin
                        interval_cnt <= INTERVAL;
                        hit_cnt <= 0;
                    end
                    if(last_scancode != scancode) begin
                        health <= 0;
                    end
                end
                DOWN: begin
                    if (interval_cnt <= 0) begin
                        interval_cnt <= 0;
                    end else begin
                        if(last_scancode != scancode) begin
                            if(hit_cnt == 0) begin
                                hit_cnt <= 1;
                                health <= health - interval_cnt[23:18];
                            end else begin
                                health <= 0;
                            end
                        end
                        interval_cnt <= interval_cnt - 1;
                    end
                end
                UP: begin
                    if (!check_en) begin
                        interval_cnt <= 0;
                    end else begin
                        if(last_scancode != scancode) begin
                            if(hit_cnt == 0) begin
                                hit_cnt <= 1;
                                health <= health - interval_cnt[23:18];
                            end else begin
                                health <= 0;
                            end
                        end
                        interval_cnt <= interval_cnt + 1;
                    end
                end
            endcase
        end
    end
    
endmodule