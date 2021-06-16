//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Air Conditioning
// Student Name: Mihnea Constantin
// Date: 16/06/21
//
// Description: A testbench module to test Ex5 - Air Conditioning
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
module top_tb(

	);

parameter CLK_PERIOD = 10;
reg clk, error;
reg [4:0] temperature;
wire heating,cooling;
reg [1:0] prev;
initial begin
	clk= 1'b0;
	forever 
		#(CLK_PERIOD/2) clk = ~clk;
end


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
air top(.clk(clk), .temperature(temperature), .heating(heating), .cooling(cooling));
endmodule		
	
