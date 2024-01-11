`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:17:17 08/24/2023 
// Design Name: 
// Module Name:    file1109_836 
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
module file1109_836(
	input clk,
	input reset,
	input [3:0] a,
	input [3:0] b,
   output ans1,
   output ans2
    );
	 
    assign ans1 = a > b;
    assign ans2 = $signed(a) > $signed(b);
endmodule
