//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Dynamic LED lights
// Student Name: Mihnea Constantin
// Date: 15/06/21
//
// Description: A testbench module to test Ex4 - Dynamic LED lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
module top_tb(

	);

parameter CLK_PERIOD = 10;

reg rst, clk, button, error;
wire [2:0] colour;
reg [2:0] prev;

initial begin
	clk= 1'b0;
	forever 
		#(CLK_PERIOD/2) clk = ~clk;
end

initial begin
	rst = 1;
	button = 0;
	error = 0;
	#(2 * CLK_PERIOD)
	if (colour != 3'b001) begin
		$display("TEST FAILED with reset!");
		error = 1;
	end
prev = colour;
rst = 0;
#(5 * CLK_PERIOD)
if(colour != prev) begin
	$display("Test FAILED with change");
	error = 1;
end
button = 1;
forever begin
	button = 1;
	prev = colour;
	#(CLK_PERIOD)
	if (prev == 3'b110)
		if (colour != 3'b001) begin
			$display("Test FAILED with change110");
			error = 1;
		end
	else
	if (prev == 3'b001)
                if (colour != 3'b010) begin
                        $display("Test FAILED with change001");
                        error = 1;
                end
	else
	if (prev == 3'b010)
                if (colour != 3'b011) begin
                        $display("Test FAILED with change010");
                        error = 1;
                end
	else
	if (prev == 3'b011)
                if (colour != 3'b100) begin
                        $display("Test FAILED with change011");
                        error = 1;
                end
	else
	if (prev == 3'b100)
                if (colour != 3'b101) begin
                        $display("Test FAILED with change100");
                        error = 1;
                end
	else
	if (prev == 3'b101)
                if (colour != 3'b110) begin
                        $display("Test FAILED with change101");
                        error = 1;
                end
end
end
initial begin
	#(50 * CLK_PERIOD)
	if(error == 0)
		$display("***TEST PASSED! :) ***");
	$finish;
end

led top(.rst(rst), .clk(clk), .button(button), .colour(colour));
endmodule
