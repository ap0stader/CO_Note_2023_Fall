`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:24:13 08/21/2023 
// Design Name: 
// Module Name:    Wire_decl 
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
module Wire_decl(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
	 wire or_in_1, or_in_2;
    
    assign or_in_1 = a & b;
    assign or_in_2 = c & d;
    assign out = or_in_1 | or_in_2;
    assign out_n = ~out;

endmodule
