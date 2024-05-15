module audio #(
        parameter  L1 = 340136, // D 调低�? 1
                    L2 = 303027, // D 调低�? 2
                    L3 = 269966, // D 调低�? 3
                    L4 = 254814, // D 调低�? 4
                    L5 = 227014, // D 调低�? 5
                    L6 = 202246, // D 调低�? 6
                    L7 = 180181, // D 调低�? 7
                    M1 = 170068, // D 调音 1
                    M2 = 151513, // D 调音 2
                    M3 = 134983, // D 调音 3
                    M4 = 127407, // D 调音 4
                    M5 = 113507, // D 调音 5
                    M6 = 101123, // D 调音 6
                    M7 = 90090,  // D 调音 7
                    H1 = 85034,  // D 调高�? 1
                    H2 = 75757,  // D 调高�? 2
                    H3 = 67492,  // D 调高�? 3
                    H4 = 63704,  // D 调高�? 4
                    H5 = 56753,  // D 调高�? 5
                    H6 = 50562,  // D 调高�? 6
                    H7 = 45045  // D 调高�? 7
    )
    (
        input  wire clk,
        input  wire rst,
        output reg  audio_out
    );

    reg  [31:0] ctr_arr;    // 预重装�??
    wire [31:0] ctr_crr;    // 比较�?
    wire [8:0]  pitch_num;  // 音乐的音调编�?
    wire [4:0]  pitch;      // 音乐的音�?
        
    //根据 rom 存储输出不同的音调输出不同的预置�?
    always @(posedge clk) begin
        if(rst) begin
            ctr_arr <= 1;
        end else begin
            case(pitch)
                5'b01_001:ctr_arr = L1; // D 调低�? 1
                5'b01_010:ctr_arr = L2; // D 调低�? 2
                5'b01_011:ctr_arr = L3; // D 调低�? 3
                5'b01_100:ctr_arr = L4; // D 调低�? 4
                5'b01_101:ctr_arr = L5; // D 调低�? 5
                5'b01_110:ctr_arr = L6; // D 调低�? 6
                5'b01_111:ctr_arr = L7; // D 调低�? 7

                5'b10_001:ctr_arr = M1; // D 调音 1
                5'b10_010:ctr_arr = M2; // D 调音 2
                5'b10_011:ctr_arr = M3; // D 调音 3
                5'b10_100:ctr_arr = M4; // D 调音 4
                5'b10_101:ctr_arr = M5; // D 调音 5
                5'b10_110:ctr_arr = M6; // D 调音 6
                5'b10_111:ctr_arr = M7; // D 调音 7

                5'b11_001:ctr_arr = H1; // D 调高�? 1
                5'b11_010:ctr_arr = H2; // D 调高�? 2
                5'b11_011:ctr_arr = H3; // D 调高�? 3
                5'b11_100:ctr_arr = H4; // D 调高�? 4
                5'b11_101:ctr_arr = H5; // D 调高�? 5
                5'b11_110:ctr_arr = H6; // D 调高�? 6
                5'b11_111:ctr_arr = H7; // D 调高�? 7
                default: ctr_arr = 32'd1;// 休止�?
            endcase
        end
    end

    // 实例�? rom
    blk_mem_gen_3 music (
        .clka(clk),        // input  wire clka
        .addra(pitch_num), // input  wire [8:0] addra
        .douta(pitch)      // output wire [4:0] douta
    );

    // 实例化音调循环器 get_pitch
    get_pitch  get_pitch(
        .clk(clk),            // input  wire clk               时钟信号
        .rst(rst),            // input  wire rst               复位信号
        .pitch_num(pitch_num) // output reg  [8:0] pitch_num   音调编号
    );

    // 实例�? pwm 生成�? pwm_gen
    pwm_gen pwm_gen(
        .clk(clk),          // input  wire clk               时钟信号
        .rst(rst),          // input  wire rst               复位信号
        .pwm_gen_en(1),     // input  wire pwm_gen_en        使能信号
        .ctr_arr(ctr_arr),  // input  wire [31:0] ctr_arr    预重装�?�，用于设定频率
        .ctr_crr(ctr_crr),  // input  wire [31:0] ctr_crr    比较值，用于调节占空�?
        .pwm_out(audio_out) // output reg  ctr_arr           输出 pwm �?
    );

    assign ctr_crr = ctr_arr >> 1; // 设置输出比较值为预重装�?�一�?
endmodule