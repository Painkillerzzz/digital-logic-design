`timescale 1ns / 1ps

module circular_motion(
        input wire clk,
        input wire reset,
        input pos xc, // Center point x coordinate
        input pos yc, // Center point y coordinate
        input pos cur_x,
        input pos cur_y,
        output pos next_x,
        output pos next_y
    );

    typedef struct packed{
        pos x;
        pos y;
    } coord_t;

    coord_t CIRCLE[0:23] = '{
        '{-43,0},
        '{-42,-11},
        '{-37,-22},
        '{-30,-30},
        '{-22,-37},
        '{-11,-42},
        '{0,-43},
        '{+11,-42},
        '{+22,-37},
        '{+30,-30},
        '{+37,-22},
        '{+42,-11},
        '{+43,0},
        '{+42,11},
        '{+37,22},
        '{+30,30},
        '{+22,37},
        '{+11,42},
        '{0,43},
        '{-11,42},
        '{-22,37},
        '{-30,30},
        '{-37,22},
        '{-42,11}
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
