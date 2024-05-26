module sram_controller (
        input wire clk,
        input wire rst,
        input wire read,
        input wire write,
        input wire [19:0] in_addr,
        output reg [19:0] out_addr,
        input wire [31:0] in_data,
        output reg [31:0] out_data,
        inout wire [31:0] base_ram_data,
        input wire [3:0] in_be_n,
        output reg [3:0] be_n,
        output reg ce_n,
        output reg oe_n,
        output reg we_n
    );

    // Internal state machine states
    typedef enum logic [2:0] {
        IDLE,
        READ_0,
        READ_1,
        WRITE_0,
        WRITE_1,
        WRITE_2
    } state_t;

    state_t current_state, next_state;

    // Tri-state buffer control
    assign base_ram_data = (current_state == WRITE_1) ? in_data : 32'bz;
    assign out_data = base_ram_data;
    
    // State machine
    always_ff @(posedge clk) begin
        if (rst)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always_comb begin
        // Default values
        ce_n = 1;
        oe_n = 1;
        we_n = 1;
        be_n = 4'b0000;
        out_addr = in_addr;
        next_state = current_state;
        
        case (current_state)
            IDLE: begin
                if (read) begin
                    next_state = READ_0;
                end else if (write) begin
                    next_state = WRITE_0;
                end
            end
            
            READ_0: begin
                ce_n = 0;
                oe_n = 0;
                next_state = READ_1;
            end
            
            READ_1: begin
                ce_n = 0;
                oe_n = 0;
                if(read) begin
                    next_state = READ_0;
                end else if(write) begin
                    next_state = WRITE_0;
                end else begin
                    next_state = IDLE;
                end
            end
            
            WRITE_0: begin
                ce_n = 0;
                be_n = in_be_n;
                next_state = WRITE_1;
            end
            
            WRITE_1: begin
                ce_n = 0;
                we_n = 0;
                be_n = in_be_n;
                next_state = WRITE_2;
            end
            
            WRITE_2: begin
                ce_n = 0;
                be_n = in_be_n;
                if(read) begin
                    next_state = READ_0;
                end else if(write) begin
                    next_state = WRITE_0;
                end else begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule