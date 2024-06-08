`timescale 1ns / 1ps
import namespace::*;

module display_controller
#(parameter WIDTH = 0, HSIZE = 0, HFP = 0, HSP = 0, HMAX = 0, VSIZE = 0, VFP = 0, VSP = 0, VMAX = 0, HSPP = 0, VSPP = 0)
    (
    // 时钟输入
    input wire clk_sram,
    input wire clk_hdmi,
    input wire clk_locked,
    input  wire btn_rst,

    input pos blueball_xc,
    input pos blueball_yc,
    input pos redball_xc,
    input pos redball_yc,
    input page_state_t page_state,
    input stage_state_t stage_state,
    
    // SRAM 操作
    inout  wire [31:0] base_ram_data,   // SRAM 鏁版�???????????????
    output wire [19:0] base_ram_addr,   // SRAM 鍦板�???????????????
    output wire [3: 0] base_ram_be_n,   // SRAM 瀛楄妭浣胯兘锛屼綆鏈夋晥銆傚鏋�???????????????笉浣跨敤瀛楄妭浣胯兘锛岃淇濇寔�????????????????0
    output wire        base_ram_ce_n,   // SRAM 鐗囬?夛紝浣庢湁鏁?
    output wire        base_ram_oe_n,   // SRAM 璇讳娇鑳斤紝浣庢湁鏁?
    output wire        base_ram_we_n,   // SRAM 鍐欎娇鑳斤紝浣庢湁鏁?
    
    // HDMI 输出
    output wire [2:0] hdmi_tmds_n,    // HDMI TMDS 鏁版嵁淇″彿
    output wire [2:0] hdmi_tmds_p,    // HDMI TMDS 鏁版嵁淇″彿
    output wire       hdmi_tmds_c_n,  // HDMI TMDS 鏃堕挓淇″彿
    output wire       hdmi_tmds_c_p   // HDMI TMDS 鏃堕挓淇″彿
    );
    
    reg [2:0]stage = 0;           //状�?�标�???????????????
    reg write;                    //正在写入的显�???????????????
    reg finish;                   //写入完成的标�???????????????
    pos write_h;           //写横坐标
    pos write_v;           //写纵坐标
    pos read_h;            //读横坐标
    pos read_v;            //读纵坐标
    reg [23:0] write_pixel;       //写入的数据，rbg
    reg [19:0] write_addr;        //写入的地�???????????????
    reg [23:0] read_pixel;        //读出的地�???????????????，rbg
    reg [19:0] read_addr;         //读出的地�???????????????
    reg [2:0]  sram_param;        //SRAM对应的参�???????????????
    reg sram_data_t;              //SRAMData的状态标�?????????????? 1�??????????????0�??????????????      
    wire hsync;
    wire vsync;
    wire data_enable;
    wire [12:0] rom_addr;         //rom地址

    reg [23:0] back_pixel;        //背景像素
    reg [23:0] ball_pixel;         //人物像素
    pos write_h_center;
    reg hgo;

    initial begin
        stage = 'd4;
        write = 0;
        finish = 0;
        write_h = 'b0;
        write_v = 'b0;
        read_h = 'b0;
        read_v = 'b0;
        write_pixel = 'b0;
        write_addr = 'b0;
        read_pixel = 'b0;
        read_addr = 'b0;
        sram_param = 3'b011;
        sram_data_t = 'b1;
        back_pixel = 'b0;
        ball_pixel = 'hFFFFFF;
        write_h_center = 11'd400;
    end

    // read_h
    always @ (posedge clk_hdmi ) begin
        if ( btn_rst )
            read_h <= 0;
        else if ( read_h == (HMAX - 1))
            read_h <= 0;
        else
            read_h <= read_h + 1;
    end

    // read_v
    always @ (posedge clk_hdmi) begin
        if ( btn_rst )
            read_v <= 0;
        else if (read_h == (HMAX - 1)) begin
            if ( read_v == (VMAX - 1))
                read_v <= 0;
            else
                read_v <= read_v + 1;
        end
    end

    // stage
    always @ (posedge clk_sram ) begin
        if( btn_rst ) begin
            write_pixel = 'b0;
            write_addr = 'b0;
            write_h = 'b0;
            write_v = 'b0;
            sram_data_t = 'b1;
            stage = 'd4;
        end else begin
            case( stage )
                3'd0:begin
                    // 如果写入没有完成
                    if( finish != 1 ) begin
                        // 计算写入的像�??????????????
                        write_pixel = ball_pixel==0?back_pixel:ball_pixel;
                        // 设置SRAM状�?�为写入
                        sram_data_t = 0;
                        // 计算写入的地�??????????????
                        write_addr = write * 480000 + write_v * 800 + write_h;
                        // 进入下一阶段
                        stage = 1;
                    end else begin // 如果写入已经完成
                        // 写入坐标归零
                        write_v = 0;
                        write_h = 0;
                        // 转到读阶�??????????????
                        stage = 4;
                    end
                end
                3'd1:begin
                    // 设置写入第一阶段引脚
                    sram_param = {1'd0, 1'd1, 1'd1}; // cow
                // 进入下一阶段
                    stage = 2;
                end
                3'd2:begin
                    // 设置写入第二阶段引脚
                    sram_param = {1'd0, 1'd1, 1'd0}; //cow
                    // 进入下一阶段
                    stage = 3;
                end
                3'd3:begin
                    // 设置写入第三阶段引脚
                    sram_param = {1'd0, 1'd1, 1'd1}; //cow
                    // 改变写入坐标
                    if( write_h == ( HSIZE - 1 ) ) begin
                        write_h = 0;
                        if( write_v == ( VSIZE - 1 ) ) begin
                            write_v = 0;
                        end else begin
                            write_v = write_v + 1;
                        end
                    end else begin
                        write_h = write_h + 1;
                    end
                    stage = 4;
                end
                3'd4:begin
                    if( finish ) begin
                        write_h = 0;
                        write_v = 0;
                    end
                    if( finish != 1 && ( (read_h >= HSIZE) || (read_v >= VSIZE) ) && read_h < HMAX - 1 ) // 如果写入未完成且在消隐区
                        stage = 0;
                    else begin // 否则�??????????????始读�??????????????
                        // 设置读出地址
                        sram_data_t = 1;
                        read_addr = !write * 480000 + read_v * 800 + read_h;
                        sram_param = {1'd0, 1'd0, 1'd1}; //cow
                        // 进入下一阶段
                        stage = 5;
                    end
                end
                3'd5:begin
                    read_pixel = base_ram_data[23:0];
                    if( (read_h < HSIZE) && (read_v < VSIZE) ) begin
                        stage = 4;
                    end else if( finish != 1 && read_h < (HMAX - 1) )begin
                        stage = 0;
                    end else
                        stage = 4;
                end
            endcase
        end   
    end

    // finish & write & back_count
    always @(posedge clk_sram ) begin
        if ( btn_rst ) begin
            finish = 0;
            write = 0;
        end else if( finish != 1 && (write_v == (VSIZE - 1) )&& ( write_h == (HSIZE - 1) ) )
            finish = 1;
        // 如果显存写入完毕并且�??????????次读取已经完�??????????
        else if( finish == 1 && (read_v == (VMAX - 1) ) && ( read_h == (HMAX - 1) ) ) begin
            finish = 0;
            write = !write;
            if( hgo == 1 ) begin
                write_h_center = write_h_center + 5;
                if( write_h_center > 600 )
                    hgo = 0;
            end else begin
                write_h_center = write_h_center - 5;
                if( write_h_center < 200 )
                    hgo = 1;
            end
        end
    end
  
    back_pixel_gen back_pixel_gen(
        .clk_sram(clk_sram),
        .write_h(write_h),
        .write_v(write_v),
        .back_pixel(back_pixel),
        .page_state(page_state)
    );

    ball_pixel_gen ball_pixel_gen(
        .clk_sram(clk_sram),
        .blueball_xc(blueball_xc),
        .blueball_yc(blueball_yc),
        .redball_xc(redball_xc),
        .redball_yc(redball_yc),
        .write_h(write_h),
        .write_v(write_v),
        .write(write),
        .ball_pixel(ball_pixel)
    );
    
    // SRAM
    assign base_ram_data = sram_data_t ? 32'bz : {8'b0, write_pixel};
    assign base_ram_addr = sram_data_t ? read_addr : write_addr;
    assign base_ram_be_n = 4'b0;
    assign base_ram_ce_n = sram_param[2];
    assign base_ram_oe_n = sram_param[1];
    assign base_ram_we_n = sram_param[0];
    
    // hsync & vsync & blank
    assign hsync = ((read_h >= HFP) && (read_h < HSP)) ? HSPP : !HSPP;
    assign vsync = ((read_v >= VFP) && (read_v < VSP)) ? VSPP : !VSPP;
    assign data_enable = ((read_h < HSIZE) & (read_v < VSIZE));

    // �???????????????? RGB 杞寲涓? HDMI TMDS 淇�?�彿骞惰緭鍑?
    ip_rgb2dvi u_ip_rgb2dvi (
        .PixelClk   (clk_hdmi),
        .vid_pVDE   (data_enable),
        .vid_pHSync (hsync),
        .vid_pVSync (vsync),
        .vid_pData  (read_pixel),
        .aRst       (~clk_locked),

        .TMDS_Clk_p  (hdmi_tmds_c_p),
        .TMDS_Clk_n  (hdmi_tmds_c_n),
        .TMDS_Data_p (hdmi_tmds_p),
        .TMDS_Data_n (hdmi_tmds_n)
    );

endmodule
module back_pixel_gen(
    input wire clk_sram,
    input page_state_t page_state,
    input wire [11:0] write_h,
    input wire [11:0] write_v,
    output reg [23:0] back_pixel
);
    wire [18:0] addra ;
    wire [11:0] s1_rgb;
    wire [11:0] s2_rgb;
    assign addra = write_h + write_v*800;
    s1_bg s1(
        .clka(clk_sram),
        .addra(addra),
        .douta(s1_rgb)
    );
    s2_bg s2(
        .clka(clk_sram),
        .addra(addra),
        .douta(s2_rgb)
    );
    always_comb begin
        if(page_state==STAGE_1)back_pixel ={s1_rgb[11:8],s1_rgb[11:8],s1_rgb[3:0],s1_rgb[3:0],s1_rgb[7:4],s1_rgb[7:4]};
        else if(page_state==STAGE_2)back_pixel = {s2_rgb[11:8],s2_rgb[11:8],s2_rgb[3:0],s2_rgb[3:0],s2_rgb[7:4],s2_rgb[7:4]};
        else back_pixel = 0;
    end
endmodule
module ball_pixel_gen(
    input wire clk_sram,
    input wire[11:0] blueball_xc,
    input wire[11:0] blueball_yc,
    input wire[11:0] redball_xc,
    input wire[11:0] redball_yc,
    input wire [11:0] write_h,
    input wire [11:0] write_v,
    input wire write,
    output reg [23:0] ball_pixel
);
    wire [9:0] addra_r;
    wire [9:0] addra_b;
    wire [5:0]draw_x_r;
    wire [5:0]draw_y_r;
    wire [5:0]draw_x_b;
    wire [5:0]draw_y_b;
    wire [7:0]rdb_r;
    wire [7:0]rdb_g;
    wire [7:0]rdb_b;
    wire [7:0]blb_r;
    wire [7:0]blb_g;
    wire [7:0]blb_b;
    wire drawing_rb;
    wire drawing_bb;
    assign drawing_bb = write_h>=blueball_xc-15&&write_h<blueball_xc+15&&write_v>=blueball_yc-15&&write_v<blueball_yc+15;
    assign drawing_rb = write_h>=redball_xc-15&&write_h<redball_xc+15&&write_v>=redball_yc-15&&write_v<redball_yc+15;
    assign draw_x_b = drawing_bb?write_h - blueball_xc+15:0;
    assign draw_y_b = drawing_bb?write_v - blueball_yc+15:0;
    assign draw_x_r = drawing_rb?write_h - redball_xc+15:0;
    assign draw_y_r = drawing_rb?write_v - redball_yc+15:0;
    assign addra_r = draw_x_r+draw_y_r*30;
    assign addra_b = draw_x_b+draw_y_b*30;

    redball_R rbr(
        .clka(clk_sram),
        .addra(addra_r),
        .douta(rdb_r)
    );
    redball_G rbg(
        .clka(clk_sram),
        .addra(addra_r),
        .douta(rdb_g)
    );
    redball_B rbb(
        .clka(clk_sram),
        .addra(addra_r),
        .douta(rdb_b)
    );
    blueball_R bbr(
        .clka(clk_sram),
        .addra(addra_b),
        .douta(blb_r)
    );
    blueball_G bbg(
        .clka(clk_sram),
        .addra(addra_b),
        .douta(blb_g)
    );
    blueball_B bbb(
        .clka(clk_sram),
        .addra(addra_b),
        .douta(blb_b)
    );
    always_ff @(posedge clk_sram) begin
        if(drawing_bb)begin
            ball_pixel <= {blb_r,blb_b,blb_g};
        end
        else if (drawing_rb)begin
            ball_pixel <= {rdb_r,rdb_b,rdb_g};
        end
        else ball_pixel <=0;
    end
    
endmodule