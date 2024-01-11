`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:55:28 08/26/2023 
// Design Name: 
// Module Name:    ALU_2 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ALU_2(
    input [4:0] inA,
    input [4:0] inB,
    input [2:0] op,
    output reg [4:0] ans
    );
	
	always @(*) begin
        case (op)
            2'b00: ans = inA + inB;
            2'b01: ans = inA - inB;
            2'b10: ans = inA | inB;
            2'b11: ans = inA & inB;
            default: ans = 4'b0000;
        endcase
    end

endmodule
