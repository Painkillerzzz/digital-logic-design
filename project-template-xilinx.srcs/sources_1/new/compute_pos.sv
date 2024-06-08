import namespace::*;

module compute_pos (
        input wire clk,
        input wire rst,
        input wire kb_change,
        input stage_state_t stage_state,
        input page_state_t page_state,
        output pos xc,
        output pos yc,
        output pos blue_xc,
        output pos blue_yc,
        output pos red_xc,
        output pos red_yc
    );

    reg [7:0]  crt_cnt;
    reg [23:0] crt_data;
    reg [23:0] cnt_traj;

    pos next_pos_xc;
    pos next_pos_yc;
    reg blue_centered; // 0为红球，1为蓝�??????

    pos cur_x;
    pos cur_y;

    assign xc =    blue_centered ? blue_xc : red_xc;
    assign yc =    blue_centered ? blue_yc : red_yc;
    assign cur_x = blue_centered ? red_xc : blue_xc;
    assign cur_y = blue_centered ? red_yc : blue_yc;

    circular_motion gemini(
        .clk(clk),
        .reset(rst),
        .xc(xc),
        .yc(yc),
        .cur_x(cur_x),
        .cur_y(cur_y),
        .next_x(next_pos_xc),
        .next_y(next_pos_yc)
    );

    pos crted_x;
    pos crted_y;

    assign crted_x = crt_data[23:12];
    assign crted_y = crt_data[11:0];

    reg crt_ena_1 = (page_state == STAGE_1);
    reg crt_ena_2 = (page_state == STAGE_2);
    reg crt_ena_3 = (page_state == STAGE_3);

// correct_1 correct_1 (
//     .clka(clk),    // input  wire clka
//     .ena(crt_ena_1),
//     .addra(crt_cnt),    // input  wire [16:0] addra
//     .douta(crt_data) // output wire [7:0] douta
// );

    correct_2 correct_2 (
        .clka(clk),    // input  wire clka
        .ena(1),
        .addra(crt_cnt),    // input  wire [16:0] addra
        .douta(crt_data) // output wire [7:0] douta
    );

// correct_3 correct_3 (
//     .clka(clk),    // input  wire clka
//     .ena(crt_ena_3),
//     .addra(crt_cnt),    // input  wire [16:0] addra
//     .douta(crt_data) // output wire [7:0] douta
// );

    always_ff @(posedge clk) begin
        if(rst) begin
            blue_xc <= 109;
            blue_yc <= 327;
            red_xc <= 66;
            red_yc <= 327;
            cnt_traj <= 0;
            crt_cnt <= 8'b0;
            blue_centered <= 1;
        end else begin
            if(kb_change && stage_state == EXECUTING) begin
                if(blue_centered)begin
                    red_xc <= crted_x;
                    red_yc <= crted_y;
                    blue_centered <= ~blue_centered;
                end else begin
                    blue_xc <= crted_x;
                    blue_yc <= crted_y;
                    blue_centered <= ~blue_centered;
                end
                crt_cnt <= crt_cnt + 1;
                cnt_traj <=0;
            end else if(cnt_traj==8_333_332)begin
                if(blue_centered)begin
                    red_xc <= next_pos_xc;
                    red_yc <= next_pos_yc;
                end else begin
                    blue_xc <= next_pos_xc;
                    blue_yc <= next_pos_yc;
                end
                cnt_traj <=0;
            end else begin
                cnt_traj <= cnt_traj + 1;
            end
        end
    end

endmodule
