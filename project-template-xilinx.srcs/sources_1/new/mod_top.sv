`timescale 1ns / 1ps

module mod_top(
    // 时钟
    input  wire clk_100m,           // 100M 输入时钟

    // �???????????�???????????
    input  wire btn_clk,            // 左侧微动�???????????关（CLK），推荐作为手动时钟，带消抖电路，按下时�??????????? 1
    input  wire btn_rst,            // 右侧微动�???????????关（RST），推荐作为手动复位，带消抖电路，按下时�??????????? 1
    input  wire [3:0]  btn_push,    // 四个按钮�???????????关（KEY1-4），按下时为 1
    input  wire [15:0] dip_sw,      // 16 位拨码开关，拨到 “ON�??????????? 时为 0

    // 32 �??????????? LED 灯，配合 led_scan 模块使用
    output wire [7:0] led_bit,      // 8 �??????????? LED 信号
    output wire [3:0] led_com,      // LED 扫描信号，每�???????????位对�??????????? 8 位的 LED 信号

    // 数码管，配合 dpy_scan 模块使用
    output wire [7:0] dpy_digit,   // 七段数码管笔段信�???????????
    output wire [7:0] dpy_segment, // 七段数码管位扫描信号

    // 以下是一些被注释掉的外设接口
    // 若要使用，不要忘记去�??????????? io.xdc 中对应行的注�???????????

    // PS/2 键盘
    input  wire        ps2_keyboard_clk,     // PS/2 键盘时钟信号
    input  wire        ps2_keyboard_data,    // PS/2 键盘数据信号

    // PS/2 鼠标
    // inout  wire       ps2_mouse_clk,     // PS/2 时钟信号
    // inout  wire       ps2_mouse_data,    // PS/2 数据信号

    // SD 卡（SPI 模式�???????????
    // output wire        sd_sclk,     // SPI 时钟
    // output wire        sd_mosi,     // 数据输出
    // input  wire        sd_miso,     // 数据输入
    // output wire        sd_cs,       // SPI 片�?�，低有�???????????
    // input  wire        sd_cd,       // 卡插入检测，0 表示有卡插入
    // input  wire        sd_wp,       // 写保护检测，0 表示写保护状�???????????

    // RGMII 以太网接�???????????
    // output wire        rgmii_clk125,
    // input  wire        rgmii_rx_clk,
    // input  wire        rgmii_rx_ctl,
    // input  wire [3: 0] rgmii_rx_data,
    // output wire        rgmii_tx_clk,
    // output wire        rgmii_tx_ctl,
    // output wire [3: 0] rgmii_tx_data,

    // 4MB SRAM 内存
    inout  wire [31:0] base_ram_data,   // SRAM 数据
    output wire [19:0] base_ram_addr,   // SRAM 地址
    output wire [3: 0] base_ram_be_n,   // SRAM 字节使能，低有效。如果不使用字节使能，请保持�???????????0
    output wire        base_ram_ce_n,   // SRAM 片�?�，低有�???????????
    output wire        base_ram_oe_n,   // SRAM 读使能，低有�???????????
    output wire        base_ram_we_n,   // SRAM 写使能，低有�???????????

    // HDMI 图像输出
    output wire [2:0] hdmi_tmds_n,    // HDMI TMDS 数据信号
    output wire [2:0] hdmi_tmds_p,    // HDMI TMDS 数据信号
    output wire       hdmi_tmds_c_n,  // HDMI TMDS 时钟信号
    output wire       hdmi_tmds_c_p,   // HDMI TMDS 时钟信号
    
    output wire beep
    );

    // 使用 100MHz 时钟作为后续逻辑的时�???????????
    wire clk_in = clk_100m;

    // PLL 分频演示，从输入产生不同频率的时�???????????
    wire clk_hdmi;
    wire clk_locked;
    ip_pll u_ip_pll(
        .clk_in1  (clk_in    ),  // 输入 100MHz 时钟
        .reset    (btn_rst   ),  // 复位信号，高有效
        .clk_out1 (clk_hdmi  ),  // 50MHz 像素时钟
        .locked   (clk_locked)   // 高表�??????????? 50MHz 时钟已经稳定输出
    );

    // 七段数码管扫描演�???????????
    dpy_scan u_dpy_scan (
        .clk     (clk_in      ),
        .number  (health      ),
        .dp      (8'b0        ),
        .digit   (dpy_digit   ),
        .segment (dpy_segment )
    );

    wire [7:0] scancode;
    wire scancode_valid;
    ps2_keyboard u_ps2_keyboard (
        .clock     (clk_in           ),
        .reset     (btn_rst          ),
        .ps2_clock (ps2_keyboard_clk ),
        .ps2_data  (ps2_keyboard_data),
        .scancode  (scancode         ),
        .valid     (scancode_valid   ),
        .change    (scancode_change  )
    );

    wire scancode_change;

    reg [7:0] hit_num;
    always @(posedge clk_in) begin
        if (btn_rst) begin
            hit_num <= 8'b0;
        end else begin
            if (scancode_change) begin
                hit_num <= hit_num + 8'b1;
            end
        end
    end
    assign leds[31:24] = hit_num;
    


    // always @(posedge clk_in) begin
    //     if (btn_rst) begin
    //         number <= 32'b0;
    //     end else begin
    //         if (scancode_valid) begin
    //             number <= {number, scancode};
    //         end
    //     end
    // end
    // 自增计数器，用于数码管演�??????????????
    // reg [31:0] counter;
    // always @(posedge clk_in) begin
    //     if (btn_rst) begin
    //         counter <= 32'b0;
    //         number <= 32'b0;
    //     end else begin
    //         counter <= counter + 32'b1;
    //         if (counter == 32'd5_000_000) begin
    //             counter <= 32'b0;
    //             number <= number + 32'b1;
    //         end
    //     end
    // end

    // LED 演示
    wire [31:0] leds;
    assign leds[0] = check_en;
    assign leds[9:8] = death_cause;
    assign leds[22:20] = page_state;
    assign leds[17:16] = stage_state;
    led_scan u_led_scan (
        .clk     (clk_in      ),
        .leds    (leds        ),
        .led_bit (led_bit     ),
        .led_com (led_com     )
    );

    // 图像输出演示，分辨率 800x600@72Hz，像素时钟为 50MHz，显示渐变色彩条
    pos hdata;  // 当前横坐�???????????
    pos vdata;  // 当前纵坐�???????????
    wire [7:0] video_red; // 红色分量
    wire [7:0] video_green; // 绿色分量
    wire [7:0] video_blue; // 蓝色分量
    wire video_clk; // 像素时钟
    wire video_hsync;
    wire video_vsync;

    pos blueball_xc;// 蓝球横坐�??????
    pos blueball_yc;// 蓝球纵坐�??????
    pos redball_xc;// 红球横坐�??????
    pos redball_yc;// 红球纵坐�??????
    pos xc;// 鼠标横坐�??????
    pos yc;// 鼠标纵坐�??????

    compute_pos u_compute_pos(
        .clk(clk_in),
        .rst(btn_rst),
        .kb_change(scancode_change),
        .page_state(page_state),
        .stage_state(stage_state),
        .xc(xc),
        .yc(yc),
        .blue_xc(blueball_xc),
        .blue_yc(blueball_yc),
        .red_xc(redball_xc),
        .red_yc(redball_yc)
    );
    

    display_controller #(12, 800, 856, 976, 1040, 600, 637, 643, 666, 1, 1) u_display_controller (
        .clk_sram(clk_in),
        .clk_hdmi(clk_hdmi),
        .clk_locked(clk_locked),
        .btn_rst(btn_rst),
        .blueball_xc(blueball_xc),
        .blueball_yc(blueball_yc),
        .redball_xc(redball_xc),
        .redball_yc(redball_yc),
        .bg_stage(2),
        .base_ram_data(base_ram_data),
        .base_ram_addr(base_ram_addr),
        .base_ram_be_n(base_ram_be_n),
        .base_ram_ce_n(base_ram_ce_n),
        .base_ram_oe_n(base_ram_oe_n),
        .base_ram_we_n(base_ram_we_n),
        .hdmi_tmds_c_p(hdmi_tmds_c_p),
        .hdmi_tmds_c_n(hdmi_tmds_c_n),
        .hdmi_tmds_p(hdmi_tmds_p),
        .hdmi_tmds_n(hdmi_tmds_n)
    );
    
    wire check_en;

    audio u_audio (
        .clk(clk_in),
        .rst(btn_rst),
        .audio_out(beep),
        .check_out(check_en)
    );


    reg [1:0] death_cause; // 0 alive, 1 hit when idle, 2 double-hit, 3 miss
    reg [8:0] health_origin;
    wire [8:0] health;
    assign health = health_origin >= 0 ? health_origin : 0;
    check_hit u_check_hit (
        .clk(clk_in),
        .rst(btn_rst),
        .scancode_change(scancode_change),
        .page_state(page_state),
        .check_en(check_en),
        .health(health_origin),
        .death_cause(death_cause),
        .hit_cnt(leds[12])
    );

    page_state_t page_state;
    stage_state_t stage_state;

    page_controller u_page_controller (
        .clk(clk_in),
        .rst(btn_rst),
        .kb_change(scancode_change),
        .stage_state(stage_state),
        .page_state(page_state)
    );

    always_comb begin
        case(page_state)
            STAGE_1:
                if(health <= 0) begin
                    stage_state = FAIL;
                end else if(xc == TARGET_XC_1 && yc == TARGET_YC_1)
                    stage_state = CLEAR;
                else begin
                    stage_state = EXECUTING;
                end
            STAGE_2:
                if(health <= 0) begin
                    stage_state = FAIL;
                end else if(xc == TARGET_XC_2 && yc == TARGET_YC_2)
                    stage_state = CLEAR;
                else begin
                    stage_state = EXECUTING;
                end
            STAGE_3:
                if(health <= 0) begin
                    stage_state = FAIL;
                end else if(xc == TARGET_XC_3 && yc == TARGET_YC_3)
                    stage_state = CLEAR;
                else begin
                    stage_state = EXECUTING;
                end
            default:
                stage_state = IDLE;
        endcase
    end

    // 7 段数码管显示
    wire [6:0] seg7_a;
    wire [6:0] seg7_b;
    wire [6:0] seg7_c;
    wire [6:0] seg7_d;
endmodule
