module get_pitch(
    input wire clk,
    input wire rst,
    output reg [8:0] pitch_num
);

reg [23:0]cnt_125;

parameter MCNT_125_MAX = 12500000;

// 分频125ms
always @(posedge clk) begin
    if(rst) begin
        cnt_125 <= 0;
    end else if(cnt_125 == MCNT_125_MAX - 1) begin
        cnt_125 <= 0;
    end else begin
        cnt_125 <= cnt_125 + 1;
    end
end

// 循环分配音调
always @(posedge clk) begin
    if(rst) begin
        pitch_num <= 0;
    end else if(cnt_125 == MCNT_125_MAX - 1) begin
        pitch_num <= pitch_num + 1;
    end else begin
        pitch_num <= pitch_num;
    end
end

endmodule