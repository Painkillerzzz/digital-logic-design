`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/07 00:10:44
// Design Name: 
// Module Name: variable_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

package namespace;

    typedef logic [11:0] pos;

    typedef enum logic [2:0] { 
        START_PAGE,
        STAGE_1,
        STAGE_1_CLEAR,
        STAGE_2,
        STAGE_2_CLEAR,
        STAGE_3,
        STAGE_3_CLEAR,
        END_PAGE
    } page_state_t;

    typedef enum logic [1:0] { 
        IDLE,
        EXECUTING,
        CLEAR,
        FAIL
    } stage_state_t;

    parameter   TARGET_XC_1 = 711,
                TARGET_YC_1 = 327,
                TARGET_XC_2 = 711,
                TARGET_YC_2 = 327,
                TARGET_XC_3 = 711,
                TARGET_YC_3 = 327;

endpackage

module variable_controller(

    );
endmodule
