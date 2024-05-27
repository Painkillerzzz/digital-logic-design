`timescale 1ns / 1ps

module circular_motion(
    input wire clk,
    input wire reset,
    input wire [11:0] xc, // Center point x coordinate
    input wire [11:0] yc, // Center point y coordinate
    input wire [11:0] cur_x,
    input wire [11:0] cur_y,
    output reg [11:0] next_x,
    output reg [11:0] next_y
);
typedef struct packed{
        reg [11:0] x;
        reg [11:0] y;
    } coord_t;

coord_t CIRCLE[0:23] = '{
    '{-80,0},
    '{-77,21},
    '{-69,+40},
    '{-57,+57},
    '{-40,+69},
    '{-21,+77},
    '{0,+80},
    '{+21,+77},
    '{+40,+69},
    '{+57,+57},
    '{+69,+40},
    '{+77,+21},
    '{+80,0},
    '{+77,-21},
    '{+69,-40},
    '{+57,-57},
    '{+40,-69},
    '{+21,-77},
    '{0,-80},
    '{-21,-77},
    '{-40,-69},
    '{-57,-57},
    '{-69,-40},
    '{-77,-21}
};
integer i;

always @(posedge clk) begin
    if (reset) begin
        next_x <= xc + CIRCLE[0].x;
        next_y <= yc + CIRCLE[0].y;
    end else begin
        // Find the current index
        for (i = 0; i < 24; i = i + 1) begin
            if ((cur_x == xc + CIRCLE[i].x) && (cur_y == yc + CIRCLE[i].y)) begin
                // Increment index to get the next point
                next_x <= xc + CIRCLE[(i + 1) % 24].x;
                next_y <= yc + CIRCLE[(i + 1) % 24].y;
                break;
            end
        end
    end
end

endmodule
