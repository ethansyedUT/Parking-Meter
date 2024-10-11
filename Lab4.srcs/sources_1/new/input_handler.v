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
    input wire clk, btnU, btnR, btnL, btnD,
    input wire [1:0] sw,
    output wire dbtnU, dbtnR, dbtnL, dbtnD,
    output reg [1:0] dsw
);
    // Debounce instances for each button
    debounce u_debounce_U(btnU, clk, dbtnU);
    debounce u_debounce_R(btnR, clk, dbtnR);
    debounce u_debounce_L(btnL, clk, dbtnL);
    debounce u_debounce_D(btnD, clk, dbtnD);

    // Switch handling
    always @(posedge clk) begin
        dsw <= sw;
    end

endmodule

// Debounce module
module debounce(
    input wire pb_1, clk,
    output wire pb_out
);
    wire Q1, Q2, Q2_bar, Q0;

    my_dff d0(clk, pb_1, Q0);
    my_dff d1(clk, Q0, Q1);
    my_dff d2(clk, Q1, Q2);

    assign Q2_bar = ~Q2;
    assign pb_out = Q1 & Q2_bar;
endmodule

// D-flip-flop for debouncing module 
module my_dff(
    input wire DFF_CLOCK, D,
    output reg Q
);
    always @(posedge DFF_CLOCK) begin
        Q <= D;
    end
endmodule