`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2024 07:41:27 PM
// Design Name: 
// Module Name: controller
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


module controller(
    input wire clk, btnU, btnR, btnL, btnD,
    input wire [1:0] sw,
    output reg on,
    output reg [13:0] meter_time
    );
    initial begin
        meter_time <= 0;
    end
    
    // Half sec pulsing
    wire half_sec_pulse;
    reg [1:0] half_sec_track;
    half_sec_gen sec(.clk(clk), .slowClk(half_sec_pulse)); // Generate every 0.5 seconds 
    
    reg cu, cr,cl,cd;
    reg su,sr,sl,sd;
    
    
    always @(posedge clk) begin
        if(sw[0] == 1)begin
            meter_time <= 10;
            on <= 1;
        end
        else if (sw[1] == 1)begin
            meter_time <= 205;
            on <= 1;
        end else begin
            //Add coins logic
            if(btnU)begin
                meter_time = meter_time + 10;
            end
            if(btnL)begin
                meter_time = meter_time + 180;
            end
            if(btnR)begin
                meter_time = meter_time + 200;
            end
            if(btnD)begin
                meter_time = meter_time + 550;
            end
            
            if(meter_time > 9999)
                meter_time = 9999;
         
            // Countdown logic 
            if(half_sec_pulse) begin
                half_sec_track = half_sec_track + 1;
                if(half_sec_track == 2) 
                    meter_time = (meter_time == 0)? 0 : meter_time - 1;
                    
                // Blinking logic
                if(meter_time == 0)begin
                    on <= ~on;
                end
                else if(meter_time < 200) begin
                    if(half_sec_track == 2)begin
                        on <= ~on;
                    end
                end else
                    on <= 1; 
                    
                if(half_sec_track == 2)
                    half_sec_track <= 0; 
            end
            
                 
        end
    end
    
    
endmodule
