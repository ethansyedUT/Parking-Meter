`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 06:39:24 PM
// Design Name: 
// Module Name: system
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


module system(
    input clk, btnU, btnR, btnL, btnD,
    input [1:0] sw,
    output [6:0] seg,
    output [3:0] an
    );

    // Internal Signals
       wire dbtnU, dbtnR, dbtnL, dbtnD; // debounced + single pulse signals
       wire [1:0] dsw;
       
       wire on;
       wire[13:0] meter_time;
       
    //
    input_handler input_handler_inst (
        .clk(clk),
        .btnU(btnU),
        .btnR(btnR),
        .btnL(btnL),
        .btnD(btnD),
        .sw(sw),
        .dbtnU(dbtnU),
        .dbtnR(dbtnR),
        .dbtnL(dbtnL),
        .dbtnD(dbtnD),
        .dsw(dsw)
    );
    
    controller controller_inst (
        .clk(clk),
        .btnU(dbtnU),
        .btnR(dbtnR),
        .btnL(dbtnL),
        .btnD(dbtnD),
        .sw(dsw),
        .on(on),
        .meter_time(meter_time)
    );
    
    output_handler output_handler_inst (
        .clk(clk),
        .on(on),
        .meter_time(meter_time),
        .seg(seg),
        .an(an)
    );

endmodule
