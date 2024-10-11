`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 05:09:55 PM
// Design Name: 
// Module Name: Display_Controller
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


module Display_Controller(
    input wire clk, on,
    input wire [3:0] thousands,
    input wire [3:0] hundreds,
    input wire [3:0] tens,
    input wire [3:0] ones,
    output reg [6:0] seg,
    output reg [3:0] an
    );
    
    
    reg [1:0] digit_select;
    reg [16:0] refresh_counter;

    always @(posedge clk) begin
        refresh_counter <= refresh_counter + 1;
        if (refresh_counter == 0) begin
            digit_select <= digit_select + 1;
        end
    end

    always @(*) begin
        case (digit_select)
            2'b00: begin
                an = (on) ? 4'b1110 : 4'b1111;
                seg = seven_segment_encoder(ones);
            end
            2'b01: begin
                an = (on) ? 4'b1101 : 4'b1111;
                seg = seven_segment_encoder(tens);
            end
            2'b10: begin
                an = (on) ? 4'b1011 : 4'b1111;
                seg = seven_segment_encoder(hundreds);
            end
            2'b11: begin
                an = (on) ? 4'b0111 : 4'b1111;
                seg = seven_segment_encoder(thousands);
            end
        endcase
    end

    function [6:0] seven_segment_encoder;
        input [3:0] bcd;
        begin
            case (bcd)
                4'h0: seven_segment_encoder = 7'b1000000;
                4'h1: seven_segment_encoder = 7'b1111001;
                4'h2: seven_segment_encoder = 7'b0100100;
                4'h3: seven_segment_encoder = 7'b0110000;
                4'h4: seven_segment_encoder = 7'b0011001;
                4'h5: seven_segment_encoder = 7'b0010010;
                4'h6: seven_segment_encoder = 7'b0000010;
                4'h7: seven_segment_encoder = 7'b1111000;
                4'h8: seven_segment_encoder = 7'b0000000;
                4'h9: seven_segment_encoder = 7'b0010000;
                default: seven_segment_encoder = 7'b1111111;
            endcase
        end
    endfunction
    
endmodule
