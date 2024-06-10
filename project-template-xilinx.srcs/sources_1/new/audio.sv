import namespace::*;

module audio #(
        parameter   MCNT_125_MAX = 40_000_000, // 0.5s 
                    STACCATO_MAX = 35_000_000, // 0.45s
                    CHECK_START  = 20_200_000,
                    CHECK_END    = 19_800_000,
                    L1 = 340136, // D 调低�???????? 1
                    L2 = 321046, // D 调低�???????? 2
                    L3 = 303027, // D 调低�???????? 3
                    L4 = 286019, // D 调低�???????? 4
                    L5 = 269966, // D 调低�???????? 5
                    L6 = 254814, // D 调低�???????? 6
                    L7 = 240512, // D 调低�???????? 7
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
                    H1 = 85034,  // D 调高�???????? 1
                    H2 = 80261,
                    H3 = 75757,  // D 调高�???????? 2
                    H4 = 71505,
                    H5 = 67492,  // D 调高�???????? 3
                    H6 = 63704,  // D 调高�???????? 4
                    H7 = 60128,
                    H8 = 56753,  // D 调高�???????? 5
                    H9 = 53568,
                    H10 = 50562,  // D 调高�???????? 6
                    H11 = 47724,
                    H12 = 45045  // D 调高�???????? 7
    )
    (
        input  wire clk,
        input  wire rst,
        input page_state_t page_state,
        input stage_state_t stage_state,
        output reg  audio_out,
        output reg  check_out
    );

    reg  [31:0] ctr_arr;    // 预重装�??
    wire [31:0] ctr_crr;    // 比较�????????
    reg  [8:0]  pitch_num;  // 音乐的音调编�????????
    reg [7:0]  pitch;      // 音乐的音�????????
    reg  pwm_gen_en;
        
    //根据 rom 存储输出不同的音调输出不同的预置�????????
    always @(posedge clk) begin
        if(rst) begin
            ctr_arr <= 1;
        end else begin
            case(pitch[5:0])
                6'b01_0001:ctr_arr = L1; // D 调低�????????? 1
                6'b01_0010:ctr_arr = L2; // D 调低�????????? 2
                6'b01_0011:ctr_arr = L3; // D 调低�????????? 3
                6'b01_0100:ctr_arr = L4; // D 调低�????????? 4
                6'b01_0101:ctr_arr = L5; // D 调低�????????? 5
                6'b01_0110:ctr_arr = L6; // D 调低�????????? 6
                6'b01_0111:ctr_arr = L7; // D 调低�????????? 7
                6'b01_1000:ctr_arr = L8; // D 调低�???????? 8
                6'b01_1001:ctr_arr = L9; // D 调低�???????? 9
                6'b01_1010:ctr_arr = L10; // D 调低�???????? 10
                6'b01_1011:ctr_arr = L11; // D 调低�???????? 11
                6'b01_1100:ctr_arr = L12; // D 调低�???????? 12

                6'b10_0001:ctr_arr = M1; // D 调do�?? 1
                6'b10_0010:ctr_arr = M2; // D 调do#�?? 2
                6'b10_0011:ctr_arr = M3; // D 调re�?? 3
                6'b10_0100:ctr_arr = M4; // D 调re#�?? 4
                6'b10_0101:ctr_arr = M5; // D 调mi�?? 5
                6'b10_0110:ctr_arr = M6; // D 调fa�?? 6
                6'b10_0111:ctr_arr = M7; // D 调fa#�?? 7
                6'b10_1000:ctr_arr = M8; // D 调so音�?????? 8
                6'b10_1001:ctr_arr = M9; // D 调so#音�?????? 9
                6'b10_1010:ctr_arr = M10; // D 调la音�?????? 10
                6'b10_1011:ctr_arr = M11; // D 调la#音�?????? 11
                6'b10_1100:ctr_arr = M12; // D 调xi音�?????? 12

                6'b11_0001:ctr_arr = H1; // D 调高�????????? 1
                6'b11_0010:ctr_arr = H2; // D 调高�????????? 2
                6'b11_0011:ctr_arr = H3; // D 调高�????????? 3
                6'b11_0100:ctr_arr = H4; // D 调高�????????? 4
                6'b11_0101:ctr_arr = H5; // D 调高�????????? 5
                6'b11_0110:ctr_arr = H6; // D 调高�????????? 6
                6'b11_0111:ctr_arr = H7; // D 调高�????????? 7
                6'b11_1000:ctr_arr = H8; // D 调高�???????? 8
                6'b11_1001:ctr_arr = H9; // D 调高�???????? 9
                6'b11_1010:ctr_arr = H10; // D 调高�???????? 10
                6'b11_1011:ctr_arr = H11; // D 调高�???????? 11
                6'b11_1100:ctr_arr = H12; // D 调高�???????? 12
                default: ctr_arr = 64'd1;// 休止�?????????
            endcase
        end
    end
    wire [7:0] s1_mu;
    wire [7:0] s2_mu;
    wire [7:0] failed_mu;
    wire [7:0] clear_mu;
    s1_music u_s1_music(
        .clka(clk),
        .addra(pitch_num),
        .douta(s1_mu)
    );
    s2_music u_s2_music (
        .clka(clk),        // input  wire clka
        .addra(pitch_num), // input  wire [8:0] addra
        .douta(s2_mu)      // output wire [7:0] douta
    );
    failed_music u_failed_music(
        .clka(clk),
        .addra(pitch_num),
        .douta(failed_mu)
    );
    clear_music u_clear_music(
        .clka(clk),
        .addra(pitch_num),
        .douta(clear_mu)
    );
    always_comb begin
        if(page_state==STAGE_1) begin
            if(stage_state == FAIL)pitch = failed_mu;
            else if(stage_state == CLEAR)pitch = clear_mu;
            else pitch = s1_mu;
        end else if (page_state==STAGE_2) begin
            if(stage_state == FAIL)pitch = failed_mu;
            else if(stage_state == CLEAR)pitch = clear_mu;
            else pitch = s2_mu;
        end else begin
            pitch = 0;
        end
    end
    reg [25:0] cnt_125;

    // 分频125ms
    always @(posedge clk) begin
        if(rst) begin
            cnt_125 <= 0;
        end else if(cnt_125 == MCNT_125_MAX - 1||(stage_state!=EXECUTING&&pitch_num>=5)) begin
            cnt_125 <= 0;
        end else begin
            cnt_125 <= cnt_125 + 1;
        end
    end

    stage_state_t last_stage_stage;

    // 循环分配音调
    always @(posedge clk) begin
        if(rst) begin
            pitch_num <= 0;
            pwm_gen_en <= 1;
            check_out <= 0;
            last_stage_stage <= IDLE;
        end else if(last_stage_stage != stage_state)begin
            pitch_num <= 0;
            pwm_gen_en <= 1;
            check_out <= 0;
            last_stage_stage <= stage_state;
        end else begin
            if(cnt_125 == MCNT_125_MAX - 1) begin
                pitch_num <= pitch_num + 1;
            end else begin
                pitch_num <= pitch_num;
            end
            if(pitch[6] && cnt_125 >= STACCATO_MAX - 1) begin
                pwm_gen_en <= 0;
            end else begin
                pwm_gen_en <= 1;
            end
            if(pitch[7] && cnt_125 == CHECK_START - 1) begin
                check_out <= 1;
            end else if(cnt_125 == CHECK_END - 1) begin
                check_out <= 0;
            end
        end
    end
 
    // 实例�???????? pwm 生成�???????? pwm_gen
    pwm_gen pwm_gen(
        .clk(clk),          // input  wire clk               时钟信号
        .rst(rst),          // input  wire rst               复位信号
        .pwm_gen_en(pwm_gen_en),     // input  wire pwm_gen_en        使能信号
        .ctr_arr(ctr_arr),  // input  wire [31:0] ctr_arr    预重装�?�，用于设定频率
        .ctr_crr(ctr_crr),  // input  wire [31:0] ctr_crr    比较值，用于调节占空�????????
        .pwm_out(audio_out) // output reg  ctr_arr           输出 pwm �????????
    );

    assign ctr_crr = ctr_arr >> 1; // 设置输出比较值为预重装�?�一�????????
endmodule