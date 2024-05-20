module audio_new #(
        parameter  L1 = 340136, // D 调低�? 1
                    L2 = 321046, // D 调低�? 2
                    L3 = 303027, // D 调低�? 3
                    L4 = 286019, // D 调低�? 4
                    L5 = 269966, // D 调低�? 5
                    L6 = 254814, // D 调低�? 6
                    L7 = 240512, // D 调低�? 7
                    L8 = 227014,
                    L9 = 214272,
                    L10 = 202246,
                    L11 = 190895,
                    L12 = 180181,
                    M1 = 170068, // D 调音 1
                    M2 = 160523,
                    M3 = 151513, // D 调音 2
                    M4 = 143010,
                    M5 = 134983, // D 调音 3
                    M6 = 127407, // D 调音 4
                    M7 = 120256,
                    M8 = 113507, // D 调音 5
                    M9 = 107136,
                    M10 = 101123, // D 调音 6
                    M11 = 95447,
                    M12 = 90090,  // D 调音 7
                    H1 = 85034,  // D 调高�? 1
                    H2 = 80261,
                    H3 = 75757,  // D 调高�? 2
                    H4 = 71505,
                    H5 = 67492,  // D 调高�? 3
                    H6 = 63704,  // D 调高�? 4
                    H7 = 60128,
                    H8 = 56753,  // D 调高�? 5
                    H9 = 53568,
                    H10 = 50562,  // D 调高�? 6
                    H11 = 47724,
                    H12 = 45045  // D 调高�? 7
    )
    (
        input  wire clk,
        input  wire rst,
        output wire  audio_out
    );

    reg  [31:0] ctr_arr;    // 预重装�??
    wire [31:0] ctr_crr;    // 比较�??
    wire [5:0]  pitch;      // 音乐的音�??
        
    //根据 rom 存储输出不同的音调输出不同的预置�??
    always @(posedge clk) begin
        if(rst) begin
            ctr_arr <= 1;
        end else begin
            case(pitch)
                6'b01_0001:ctr_arr = L1; // D 调低�?? 1
                6'b01_0010:ctr_arr = L2; // D 调低�?? 2
                6'b01_0011:ctr_arr = L3; // D 调低�?? 3
                6'b01_0100:ctr_arr = L4; // D 调低�?? 4
                6'b01_0101:ctr_arr = L5; // D 调低�?? 5
                6'b01_0110:ctr_arr = L6; // D 调低�?? 6
                6'b01_0111:ctr_arr = L7; // D 调低�?? 7
                6'b01_1000:ctr_arr = L8; // D 调低�? 8
                6'b01_1001:ctr_arr = L9; // D 调低�? 9
                6'b01_1010:ctr_arr = L10; // D 调低�? 10
                6'b01_1011:ctr_arr = L11; // D 调低�? 11
                6'b01_1100:ctr_arr = L12; // D 调低�? 12

                6'b10_0001:ctr_arr = M1; // D 调音 1
                6'b10_0010:ctr_arr = M2; // D 调音 2
                6'b10_0011:ctr_arr = M3; // D 调音 3
                6'b10_0100:ctr_arr = M4; // D 调音 4
                6'b10_0101:ctr_arr = M5; // D 调音 5
                6'b10_0110:ctr_arr = M6; // D 调音 6
                6'b10_0111:ctr_arr = M7; // D 调音 7
                6'b10_1000:ctr_arr = M8; // D 调音�? 8
                6'b10_1001:ctr_arr = M9; // D 调音�? 9
                6'b10_1010:ctr_arr = M10; // D 调音�? 10
                6'b10_1011:ctr_arr = M11; // D 调音�? 11
                6'b10_1100:ctr_arr = M12; // D 调音�? 12

                6'b11_0001:ctr_arr = H1; // D 调高�?? 1
                6'b11_0010:ctr_arr = H2; // D 调高�?? 2
                6'b11_0011:ctr_arr = H3; // D 调高�?? 3
                6'b11_0100:ctr_arr = H4; // D 调高�?? 4
                6'b11_0101:ctr_arr = H5; // D 调高�?? 5
                6'b11_0110:ctr_arr = H6; // D 调高�?? 6
                6'b11_0111:ctr_arr = H7; // D 调高�?? 7
                6'b11_1000:ctr_arr = H8; // D 调高�? 8
                6'b11_1001:ctr_arr = H9; // D 调高�? 9
                6'b11_1010:ctr_arr = H10; // D 调高�? 10
                6'b11_1011:ctr_arr = H11; // D 调高�? 11
                6'b11_1100:ctr_arr = H12; // D 调高�? 12
                default: ctr_arr = 64'd1;// 休止�??
            endcase
        end
    end

    // 实例化音调循环器 get_pitch
    get_pitch_new  get_pitch(
        .clk(clk),            // input  wire clk               时钟信号
        .rst(rst),            // input  wire rst               复位信号
        .pitch(pitch)         // output reg  [5:0] pitch       音调
    );

    // 实例�?? pwm 生成�?? pwm_gen
    pwm_gen pwm_gen(
        .clk(clk),          // input  wire clk               时钟信号
        .rst(rst),          // input  wire rst               复位信号
        .pwm_gen_en(1),     // input  wire pwm_gen_en        使能信号
        .ctr_arr(ctr_arr),  // input  wire [31:0] ctr_arr    预重装�?�，用于设定频率
        .ctr_crr(ctr_crr),  // input  wire [31:0] ctr_crr    比较值，用于调节占空�??
        .pwm_out(audio_out) // output reg  pwm_out           输出 pwm �??
    );

    assign ctr_crr = ctr_arr >> 1; // 设置输出比较值为预重装�?�一�??
endmodule