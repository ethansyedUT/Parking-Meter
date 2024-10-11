`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 10:00:38 PM
// Design Name: 
// Module Name: controller_tb
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


module controller_tb();

    // Inputs
    reg clk;
    reg btnU, btnR, btnL, btnD;
    reg [1:0] sw;

    // Outputs
    wire on;
    wire [13:0] meter_time;

    // Instantiate the Unit Under Test (UUT)
    controller uut (
        .clk(clk), 
        .btnU(btnU), 
        .btnR(btnR), 
        .btnL(btnL), 
        .btnD(btnD), 
        .sw(sw), 
        .on(on), 
        .meter_time(meter_time)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    // Test scenario
    initial begin
        // Initialize Inputs
        btnU = 0; btnR = 0; btnL = 0; btnD = 0;
        sw = 2'b00;

        // Wait 100 ns for global reset to finish
        #100;

        // Test button U
        #10 btnU = 1;
        #10 btnU = 0;
        #100;

        // Test button L
        #10 btnL = 1;
        #10 btnL = 0;
        #100;

        // Test button R
        #10 btnR = 1;
        #10 btnR = 0;
        #100;

        // Test button D
        #10 btnD = 1;
        #10 btnD = 0;
        #100;

        // Test switch 0
        sw = 2'b01;
        #100;
        sw = 2'b00;

        // Test switch 1
        sw = 2'b10;
        #100;
        sw = 2'b00;

        // Let it run for a while to observe countdown
        #10000;

        $finish;
    end

    // Monitor changes
    initial begin
        $monitor("Time=%t, btnU=%b, btnR=%b, btnL=%b, btnD=%b, sw=%b, meter_time=%d, on=%b", 
                 $time, btnU, btnR, btnL, btnD, sw, meter_time, on);
    end

endmodule