`timescale 1ns / 1ps

module vram_wr(
    input wire clk,
    input wire rst,
    input wire [31:0] data_in,
    output wire ena,
    output wire [18:0]addr,
    output wire [23:0] din
);

    reg [11:0] xc;
    reg [11:0] yc;
    assign xc = data_in[23:12];
    assign yc = data_in[11:0];
    reg [11:0] draw_x;
    reg [11:0] draw_y;
    reg [11:0] xlen;
    reg [11:0] ylen;
    assign xlen = data_in[31]==1?30:800;
    assign ylen = data_in[31]==1?30:500;
    always_ff @(posedge clk or posedge rst) begin
        if(rst)begin
            draw_x<=0;
            draw_y<=0;
        end else begin
            if(draw_x>=xlen-1&&draw_y>=ylen-1)begin
                draw_y <= 0;
                draw_x <= 0;
            end else if(draw_x >= xlen-1)begin
                draw_x <= 0;
                draw_y <= draw_y+1;
            end else begin
                draw_x <= draw_x+1;
            end
        end

    end
    wire [7:0] blb_r;
    wire [7:0] blb_g;
    wire [7:0] blb_b;
    wire [7:0] rdb_r;
    wire [7:0] rdb_g;
    wire [7:0] rdb_b;
    wire [18:0] addra;
    wire [7:0]bg_r;
    wire [7:0]bg_g;
    wire [7:0]bg_b;
    assign addra = draw_x+draw_y*xlen;
    redball_R rbr(
        .clka(clk),
        .addra(addra[9:0]),
        .douta(rdb_r)
    );
    redball_G rbg(
        .clka(clk),
        .addra(addra[9:0]),
        .douta(rdb_g)
    );
    redball_B rbb(
        .clka(clk),
        .addra(addra[9:0]),
        .douta(rdb_b)
    );
    blueball_R bbr(
        .clka(clk),
        .addra(addra[9:0]),
        .douta(blb_r)
    );
    blueball_G bbg(
        .clka(clk),
        .addra(addra[9:0]),
        .douta(blb_g)
    );
    blueball_B bbb(
        .clka(clk),
        .addra(addra[9:0]),
        .douta(blb_b)
    );
    draw_bg bg(
        .clk_in(clk),
        .hdata(draw_x),
        .vdata(draw_y),
        .video_red(bg_r),
        .video_green(bg_g),
        .video_blue(bg_b)
    );
    assign addr = data_in[31]==1?(xc-15+draw_x+(yc-15+draw_y)*800):addra;
    assign din = data_in[31]==1?(data_in[30]==1?{blb_r,blb_g,blb_b}:{rdb_r,rdb_g,rdb_b}):{bg_r,bg_g,bg_b};
    assign ena = 1'b1;

endmodule
