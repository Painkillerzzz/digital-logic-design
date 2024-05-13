`timescale 1ns / 1ps

module pixel_drawer(
    input wire clk,
    input wire rst,
    input wire [11:0] hdata,
    input wire [11:0] vdata,
    output reg [7:0] video_red,
    output reg [7:0] video_green,
    output reg [7:0] video_blue
    );

reg [5:0] red [0:399][0:299];
reg [6:0] green [0:399][0:299];
reg [5:0] blue [0:399][0:299];
integer i, j;
initial begin
    for (i = 0; i < 400; i = i + 1) begin
        for (j = 0; j < 300; j = j + 1) begin
            red[i][j] = 5'b00000;
            green[i][j] = 6'b000000;
            blue[i][j] = 5'b00000;
        end
    end
    for(i=0;i<100;i=i+1) begin
        for(j=0;j<100;j=j+1) begin
            red[i][j] = 5'b11111;
            green[i][j] = 6'b111111;
            blue[i][j] = 5'b11111;
        end
    end
end
always @ (posedge clk or posedge rst) begin
    if (rst) begin
        // 复位时，将颜色设置为黑色
        video_red <= 8'b00000000;
        video_green <= 8'b00000000;
        video_blue <= 8'b00000000;
    end else begin
        // 根据坐标从内存中读取颜色数据
        video_red <= {3'b000 ,red[hdata][vdata]};
        video_green <= {2'b000, green[hdata][vdata]};
        video_blue <= {3'b000,blue[hdata][vdata]};
    end
end
endmodule
