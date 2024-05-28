module tb_sram_controller();

    // Inputs
    reg clk;
    reg rst;
    reg read;
    reg write;
    reg [19:0] in_addr;
    reg [31:0] in_data;
    reg [3:0] in_be_n;

    // Outputs
    wire [19:0] out_addr;
    wire [31:0] out_data;
    wire [3:0] be_n;
    wire ce_n;
    wire oe_n;
    wire we_n;

    // Bidirectional
    wire [31:0] base_ram_data;
    
    // Instantiate the DUT (Device Under Test)
    sram_controller dut (
        .clk(clk),
        .rst(rst),
        .read(read),
        .write(write),
        .in_addr(in_addr),
        .out_addr(out_addr),
        .in_data(in_data),
        .out_data(out_data),
        .base_ram_data(base_ram_data),
        .in_be_n(in_be_n),
        .be_n(be_n),
        .ce_n(ce_n),
        .oe_n(oe_n),
        .we_n(we_n)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        read = 0;
        write = 0;
        in_addr = 0;
        in_data = 0;
        in_be_n = 4'b1111;

        // Reset pulse
        #10;
        rst = 0;
        #10;
        rst = 1;
        #10;
        rst = 0;

        // Test Write Operation
        @(posedge clk);
        in_addr = 20'hA5A5A;
        in_data = 32'hDEADBEEF;
        in_be_n = 4'b0000;
        write = 1;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        // Test Read Operation
        @(posedge clk);
        read = 1;
        write = 0;
        @(posedge clk);

        // Additional test scenarios can be added here
        // ...

        // Finish the simulation
        #50;
        $stop;
    end

    // Monitor the signals
    initial begin
        $monitor("Time: %t | rst: %b | read: %b | write: %b | in_addr: %h | in_data: %h | out_data: %h | base_ram_data: %h | be_n: %b | ce_n: %b | oe_n: %b | we_n: %b",
                 $time, rst, read, write, in_addr, in_data, out_data, base_ram_data, be_n, ce_n, oe_n, we_n);
    end

endmodule
