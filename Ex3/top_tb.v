//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Active IoT Devices Monitor
// Student Name: Mihnea Constantin
// Date: 15/06/21
//
// Description: A testbench module to test Ex3 - Active IoT Devices Monitor
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
parameter CLK_PERIOD = 10;
//Todo: Regitsers and wires
reg rst, change, on_off, clk;
reg [7:0] prev;
reg error;
wire [7:0] counter_out;
//Todo: Clock generation
initial
	begin
		clk = 1'b0;
		forever
			#(CLK_PERIOD/2) clk = ~clk;
	end
//Todo: User logic
initial begin
$display("enters");
rst = 1;
change = 0;
on_off = 0;
error = 0;
#(CLK_PERIOD)
if (counter_out != 0) begin
	$display("TEST FAILED with reset!");
	error = 1;
end
prev = counter_out;// to see if counter remains constant if rst = 0
rst = 0;
#(CLK_PERIOD)
if(counter_out != prev) begin
	$display("Test FAILED with change");
	error = 1;
end
change = 1;
forever begin
	on_off = ~on_off;
	prev = counter_out;
	#(CLK_PERIOD)
	if (on_off) begin
		if (counter_out != (prev + 1)) begin
			$display("TEST FAILED with on_off = 1");
			error = 1;
		end
	end
	else begin
		if (counter_out != (prev - 1)) begin
			$display("TEST FAILED with on_off = 0");
			error = 1;
		end
	end
end
end
//Todo: Finish test, check for success
initial begin 
	#(100*CLK_PERIOD)
	if(error == 0)
		$display("TEST PASSED!");
	else
		$display("TEST FAILED!!");
	$finish;
	end
//Todo: Instantiate counter module
 monitor top(.clk(clk), .rst(rst), .change(change), .on_off(on_off), .counter_out(counter_out));
endmodule 

