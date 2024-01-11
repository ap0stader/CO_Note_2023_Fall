`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:23:44 08/24/2023
// Design Name:   file1109_836
// Module Name:   /home/co-eda/ISE/sample/file1109_836test.v
// Project Name:  sample
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: file1109_836
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module file1109_836test;

	// Inputs
	reg clk;
	reg reset;
	reg [3:0] a;
	reg [3:0] b;

	// Outputs
	wire ans1;
	wire ans2;

	// Instantiate the Unit Under Test (UUT)
	file1109_836 uut (
		.clk(clk), 
		.reset(reset), 
		.a(a), 
		.b(b), 
		.ans1(ans1), 
		.ans2(ans2)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		a = 0;
		b = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
		a = 4;
		b = -1;
		#2;
		a = 4;
		b = 7;
      #2;
      a = 4;
		b = 15;     

	end
      
endmodule

