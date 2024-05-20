module get_pitch_new(
        input  wire clk,
        input  wire rst,
        output reg [5:0] pitch
    );

    reg [23:0] cnt_125;
    reg rom_ena;
    reg [6:0]  pitch_rom;
    reg [8:0]  pitch_num;

    parameter MCNT_125_MAX = 12500000;
    parameter MCNT_120_MAX = 12000000;

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
            pitch_rom <= 0;
        end else begin
            if(cnt_125 == MCNT_125_MAX - 1) begin
                rom_ena <= 1;
                pitch_num <= pitch_num + 1;
            end else begin
                pitch_num <= pitch_num;
            end
//            if(pitch_rom[6] && cnt_125 == MCNT_120_MAX - 1) begin
//                rom_ena <= 0;
//                pitch_rom <= 0;
//            end
        end
    end

    // 实例�?? rom
    blk_mem_gen_3 music (
        .clka(clk),        // input  wire clka
        .addra(pitch_num), // input  wire [8:0] addra
        .douta(pitch_rom)      // output wire [6:0] douta
    );

    // 输出音调
    assign pitch = pitch_rom[5:0];

endmodule