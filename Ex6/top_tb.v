//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - RGB Colour Converter
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex6 - RGB Colour Converter
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
	);

parameter CLK_PERIOD = 10;

reg clk, enable, error;
reg [2:0] colour;
wire [23:0] rgb;
reg [23:0] prev;

initial begin
	clk = 1'b0;
	forever
		#(CLK_PERIOD/2) clk=~clk;
end

initial begin
error = 0;
enable = 0;
colour = 3'b001;
#(CLK_PERIOD);
if (rgb != 24'b0) begin
	$display("TEST FAILED");
	error = 1;
end

forever begin
	enable = 1;
	prev = rgb;
	colour = colour + 3'b1;
	#(CLK_PERIOD)
	if (prev == rgb) begin
		$display("TEST FAILED");
		error = 1;
	end
end
end

initial begin
	#(50*CLK_PERIOD)
	if(error == 0)
		$display("TEST PASSED!!");
		$finish;
end

rgb top(.clk(clk), .enable(enable), .rgb(rgb), .colour(colour));
endmodule
