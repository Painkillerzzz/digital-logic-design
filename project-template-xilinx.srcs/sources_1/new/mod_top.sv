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
    // inout  wire [31:0] base_ram_data,   // SRAM 数据
    // output wire [19:0] base_ram_addr,   // SRAM 地址
    // output wire [3: 0] base_ram_be_n,   // SRAM 字节使能，低有效。如果不使用字节使能，请保持�???????????0
    // output wire        base_ram_ce_n,   // SRAM 片�?�，低有�???????????
    // output wire        base_ram_oe_n,   // SRAM 读使能，低有�???????????
    // output wire        base_ram_we_n,   // SRAM 写使能，低有�???????????

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
    reg [31:0] number;
    dpy_scan u_dpy_scan (
        .clk     (clk_in      ),
        .number  (number      ),
        .dp      (8'b0        ),

        .digit   (dpy_digit   ),
        .segment (dpy_segment )
    );
    // 在数码管上显�??????????? PS/2 Keyboard scancode
    wire [7:0] scancode;
    wire scancode_valid;
    ps2_keyboard u_ps2_keyboard (
        .clock     (clk_in           ),
        .reset     (btn_rst          ),
        .ps2_clock (ps2_keyboard_clk ),
        .ps2_data  (ps2_keyboard_data),
        .scancode  (scancode         ),
        .valid     (scancode_valid   )
    );

    // always @(posedge clk_in) begin
    //     if (btn_rst) begin
    //         number <= 32'b0;
    //     end else begin
    //         if (scancode_valid) begin
    //             number <= {number, scancode};
    //         end
    //     end
    // end
    // 自增计数器，用于数码管演�???????????
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
    assign leds[15:0] = number[15:0];
    assign leds[31:16] = ~(dip_sw) ^ btn_push;
    led_scan u_led_scan (
        .clk     (clk_in      ),
        .leds    (leds        ),

        .led_bit (led_bit     ),
        .led_com (led_com     )
    );

    // 图像输出演示，分辨率 800x600@72Hz，像素时钟为 50MHz，显示渐变色彩条
    wire [11:0] hdata;  // 当前横坐�???????????
    wire [11:0] vdata;  // 当前纵坐�???????????
    wire [7:0] video_red; // 红色分量
    wire [7:0] video_green; // 绿色分量
    wire [7:0] video_blue; // 蓝色分量
    wire video_clk; // 像素时钟
    wire video_hsync;
    wire video_vsync;

    reg blue_centered;// 0为红球，1为蓝�???
    reg [7:0] last_scancode;
    always_ff @(posedge clk_in) begin
        if(btn_rst) begin
            blue_centered <= 1;
            last_scancode <= 8'b0;
        end
        else begin
            if(scancode_valid && scancode != last_scancode) begin
                blue_centered <= ~blue_centered;
                last_scancode <= scancode;
            end
        end
    end
    reg[11:0] blueball_xc;// 蓝球横坐�???
    reg[11:0] blueball_yc;// 蓝球纵坐�???
    reg[11:0] redball_xc;// 红球横坐�???
    reg[11:0] redball_yc;// 红球纵坐�???
    reg[11:0] next_pos_xc;
    reg[11:0] next_pos_yc;
    reg[23:0] cnt_traj;
    wire [11:0] xc;
    wire [11:0] yc;
    wire [11:0] cur_x;
    wire [11:0] cur_y;
    assign xc = blue_centered ? blueball_xc : redball_xc;
    assign yc = blue_centered ? blueball_yc : redball_yc;
    assign cur_x = blue_centered ? redball_xc : blueball_xc;
    assign cur_y = blue_centered ? redball_yc : blueball_yc;
    circular_motion gemini(
            .clk(clk_hdmi),
            .reset(btn_rst),
            .xc(xc),
            .yc(yc),
            .cur_x(cur_x),
            .cur_y(cur_y),
            .next_x(next_pos_xc),
            .next_y(next_pos_yc)
    );
    always_ff @(posedge clk_in) begin
        if(btn_rst) begin
            blueball_xc <= 200;
            blueball_yc <=125;
            redball_xc <=120;
            redball_yc <=125;
            cnt_traj <=0;
        end
        else begin
            if(cnt_traj==12500000-1)begin
                if(blue_centered)begin
                    redball_xc <= next_pos_xc;
                    redball_yc <= next_pos_yc;
                end else begin
                    blueball_xc <= next_pos_xc;
                    blueball_yc <= next_pos_yc;
                end
                cnt_traj <=0;
            end
            else begin
            cnt_traj <= cnt_traj+1;
            end
        end
    end
    reg [31:0] data_in;
    reg [31:0] counter;
    always_ff @(posedge clk_hdmi) begin
        if(btn_rst) begin
            counter <= 0;
            data_in <= {1'b1,1'b1,6'b000000,blueball_xc,blueball_yc};
        end else begin
            if (counter<1000) begin
                counter <= counter +1;
                data_in <= {1'b1,1'b1,6'b000000,blueball_xc,blueball_yc};
            end else if (counter < 2000) begin
                counter <= counter +1;
                data_in <= {1'b1,1'b0,6'b000000,redball_xc,redball_yc};
            end else if(counter<1000000)begin
                counter <= counter +1;
            end else if (counter < 2500000) begin
                counter <= counter + 1;
                data_in <= 0;
            end else begin
                counter <= 0;
            end
        end
    end
    
    wire ena;
    wire enb;
    wire[16:0] addra;
    wire[16:0] addrb;
    wire[23:0] dina;
    wire[23:0] op;
    vram_wr u_vram_wr(
        .clk(clk_hdmi),
        .rst(btn_rst),
        .data_in(data_in),
        .ena(ena),
        .addr(addra),
        .din(dina)
    );
    vram_rd u_vram_rd(
        .clk(clk_hdmi),
        .rst(btn_rst),
        .hdata(hdata),
        .vdata(vdata),
        .ena(enb),
        .addr(addrb)
    );
    vram v(
        .clka(clk_hdmi),
        .ena(ena),
        .wea(ena),
        .addra(addra),
        .dina(dina),
        .clkb(clk_hdmi),
        .enb(enb),
        .addrb(addrb),
        .doutb(op)
    );
    assign video_red = op[23:16];
    assign video_green = op[15:8];
    assign video_blue = op[7:0];
    
    // 图像输出演示，分辨率 800x600@72Hz，像素时钟为 50MHz，显示渐变色彩条
    // 生成彩条数据，分别取坐标低位作为 RGB �???????????
    // 图像输出演示，分辨率 800x600@72Hz，像素时钟为 50MHz，显示渐变色彩条
    // 生成彩条数据，分别取坐标低位作为 RGB �???????????
    // 警告：该图像生成方式仅供演示，请勿使用横纵坐标驱动大量�?�辑！！
    assign video_clk = clk_hdmi;

    video #(12, 800, 856, 976, 1040, 600, 637, 643, 666, 1, 1) u_video800x600at72 (
        .clk(video_clk), 
        .hdata(hdata), //横坐�???????????
        .vdata(vdata), //纵坐�???????????
        .hsync(video_hsync),
        .vsync(video_vsync),
        .data_enable(video_de)
    );

    // �??????????? RGB 转化�??????????? HDMI TMDS 信号并输�???????????
    ip_rgb2dvi u_ip_rgb2dvi (
        .PixelClk   (video_clk),
        .vid_pVDE   (video_de),
        .vid_pHSync (video_hsync),
        .vid_pVSync (video_vsync),
        .vid_pData  ({video_red, video_blue, video_green}),
        .aRst       (~clk_locked),

        .TMDS_Clk_p  (hdmi_tmds_c_p),
        .TMDS_Clk_n  (hdmi_tmds_c_n),
        .TMDS_Data_p (hdmi_tmds_p),
        .TMDS_Data_n (hdmi_tmds_n)
    );
    
    audio u_audio (
        .clk(clk_in),
        .rst(btn_rst),
        .audio_out(beep)
    );
endmodule
