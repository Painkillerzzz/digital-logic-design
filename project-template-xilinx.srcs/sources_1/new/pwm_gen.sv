module  pwm_gen(
    input  wire clk,
    input  wire rst,
    input  wire pwm_gen_en,
    input  wire [31:0] ctr_arr,
    input  wire [31:0] ctr_crr,
    output reg  pwm_out
);

reg [31:0] cnt;

always @(posedge clk)
    if (rst) begin
        cnt <= ctr_arr; // 初始化时，加载预重装寄存器�??
    end else if(pwm_gen_en) begin
        if (cnt <= 1) begin
            cnt <= ctr_arr; // 计数器减�?1时，加载预重装寄存器�?
        end else begin
            cnt <= cnt - 1; // 计数器减1
        end
    end else begin
        cnt <= ctr_arr; // 未使能时，加载预重装寄存器�??
    end

always @(posedge clk)
    if (rst) begin
        pwm_out <= 0; // 复位时，输出低电�?
    end else if(cnt <= ctr_crr) begin
        pwm_out <= 1;
    end else begin
        pwm_out <= 0;
    end

endmodule