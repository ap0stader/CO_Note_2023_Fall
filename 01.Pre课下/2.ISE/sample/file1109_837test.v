`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:32:01 08/24/2023
// Design Name:   file1109_837
// Module Name:   /home/co-eda/ISE/sample/file1109_837test.v
// Project Name:  sample
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: file1109_837
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module file1109_837test;

	// Inputs
	reg clk;
	reg reset;
	reg [3:0] a;
	reg [3:0] b;

	// Outputs
	wire [3:0] ans1;
	wire [3:0] ans2;
	wire [3:0] ans3;

	// Instantiate the Unit Under Test (UUT)
	file1109_837 uut (
		.clk(clk), 
		.reset(reset), 
		.a(a), 
		.b(b), 
		.ans1(ans1), 
		.ans2(ans2), 
		.ans3(ans3)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		a = 0;
		b = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		a=3;
		b=1;
		#2;
		a=-2;
		b=1;

	end
      
endmodule

