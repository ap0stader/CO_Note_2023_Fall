`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:54:55 08/26/2023 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [4:0] inA,
    input [4:0] inB,
    input [2:0] op,
    output [4:0] ans
    );
	 
	assign ans = (op == 2'b00) ? inA + inB :
                (op == 2'b01) ? inA - inB :
                (op == 2'b10) ? inA | inB :
                (op == 2'b11) ? inA & inB :
					 4'b0000; // error

endmodule
