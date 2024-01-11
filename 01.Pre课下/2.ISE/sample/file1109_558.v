`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:14:20 08/24/2023 
// Design Name: 
// Module Name:    file1109_558 
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
module file1109_558(
		input clk,
		input a,
		input b,
		input c
    );

	wire mem;
	
	initial begin
		mem = 0;
	end
	
	always @(posedge clk)begin
		mem = a&b;
	end
		
	assign c = mem;

endmodule
