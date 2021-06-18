//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #8  - Simple End-to-End Design
// Student Name: Mihnea Constantin
// Date: 18/06/21
//
// Description: A testbench module to test Ex8
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(

	);

parameter CLK_PERIOD = 10;
reg clk_p, error;
wire clk_n;
reg [4:0] temperature;
wire heating,cooling;
reg [1:0] prev;
initial begin
	clk_p = 1'b0;
	forever 
		#(CLK_PERIOD/2) clk_p = ~clk_p;
end

assign clk_n = ~clk_p;
initial begin
	temperature = 5'b10100;
	error = 0;
	#(2 * CLK_PERIOD)
	if({heating, cooling} != 2'b00) begin
		$display("TEST FAILED initially with 20!");
		error = 1;
	end
	temperature = 5'b10011;
        #(CLK_PERIOD)
        if({heating, cooling} != 2'b00) begin
                $display("TEST FAILED initially with 19!");
                error = 1;
        end
	temperature = 5'b10101;
        #(CLK_PERIOD)
        if({heating, cooling} != 2'b00) begin
                $display("TEST FAILED initially with 21!");
                error = 1;
        end
	temperature = 5'b10000;
        #(CLK_PERIOD)
        if({heating, cooling} != 2'b10) begin
                $display("TEST FAILED idle state at 16!");
                error = 1;
        end
	temperature = 5'b10100;
        #(CLK_PERIOD)
        if({heating, cooling} != 2'b00) begin
                $display("TEST FAILED heating state at 20!");
                error = 1;
        end                 
        temperature = 5'b11000;
        #(CLK_PERIOD)
        if({heating, cooling} != 2'b01) begin
                $display("TEST FAILED idle state at 24!");
                error = 1;
        end
	temperature = 5'b10100;
        #(CLK_PERIOD)
        if({heating, cooling} != 2'b00) begin
                $display("TEST FAILED cooling state at 20!");
                error = 1;
        end
temperature = 5'b10000;       
forever begin
	#(CLK_PERIOD)
	if (temperature <= 5'b10010) begin
		if (heating != 1) begin
			$display("TEST FAILED heating!");
			error = 1;
		end
	end
	else
	if(temperature >= 5'b10110) begin
		if(cooling != 1) begin
			$display("TEST FAILED cooling!");
                        error =	1;
                end
	end
	temperature = temperature + heating - cooling;
end
end
initial begin
	#(50 * CLK_PERIOD)
	if(error == 0)
		$display("***TEST PASSED! :) ***");
	$finish;
end
top top(.clk_p(clk_p),.clk_n(clk_n),
 .temperature_0(temperature[0]), .heating(heating), .cooling(cooling),
.temperature_1(temperature[1]),
.temperature_2(temperature[2]),
.temperature_3(temperature[3]),
.temperature_4(temperature[4]),
.rst_n(1'b0)
);
endmodule		
	
