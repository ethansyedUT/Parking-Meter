`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2024 07:41:01 PM
// Design Name: 
// Module Name: input_handler
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


module input_handler(
    input clk, btnU, btnR, btnL, btnD,
    input [1:0] sw,
    output reg [3:0] led
    );
    
    localparam ms50 = 500_000_000;
    reg [18:0] reloadU = ms50;
    reg [18:0] reloadR = ms50;
    reg [18:0] reloadL = ms50;
    reg [18:0] reloadD = ms50;
    
    initial begin
        led = 4'b1111;
    end
    
    always@(posedge clk)begin
        if(sw[0] == 1)begin
            reloadU <= ms50;
            reloadR <= ms50;
            reloadL <= ms50;
            reloadD <= ms50;
            led = 4'b1111;
        end
        else if (sw[1] == 1)begin
            reloadU <= ms50;
            reloadR <= ms50;
            reloadL <= ms50;
            reloadD <= ms50;
            led = 4'b1111;
        end else begin
            if(btnU && reloadU == 0)begin
                led[0] = 0;
                reloadU <= ms50;
            end else
                reloadU = (reloadU == 0) ? 0 : reloadU - 1;
            if(btnL && reloadL == 0)begin
                led[1] = 0;
                reloadL = ms50;
            end else         
                reloadL = (reloadL == 0) ? 0 : reloadL - 1;
            if(btnR && reloadR == 0)begin
                led[2] = 0;
                reloadR <= ms50;
            end else
                reloadR = (reloadR == 0) ? 0 : reloadR - 1;
            if(btnD && reloadD == 0)begin
                led[3] = 0;
                reloadD <= ms50;
            end else
                reloadD = (reloadD == 0) ? 0 : reloadD - 1;
            
            
        end
    
    end
    
endmodule
