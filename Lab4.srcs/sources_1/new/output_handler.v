`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2024 07:42:34 PM
// Design Name: 
// Module Name: output_handler
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


module output_handler(
    input wire clk, on,
    input wire [13:0] meter_time,
    output wire [6:0] seg,
    output wire [3:0] an
    );
    wire [3:0] bcd_thousands, bcd_hundreds, bcd_tens, bcd_ones;
    
    Binary_to_BCD convert(
        .binary(meter_time),         
        .thousands(bcd_thousands),
        .hundreds(bcd_hundreds),
        .tens(bcd_tens),
        .ones(bcd_ones)
    );
    
    
        // Seven Seg Controller
    Display_Controller display_ctrl(
        .clk(clk),
        .on(on),
        .thousands(bcd_thousands),
        .hundreds(bcd_hundreds),
        .tens(bcd_tens),
        .ones(bcd_ones),
        .seg(seg),
        .an(an)
    ); 
    
    
endmodule
