//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 - Air Conditioning
// Student Name: Mihnea Constantin
// Date: 16/06/21
//
//  Description: In this exercise, you need to an air conditioning control system
//  According to the state diagram provided in the exercise.
//
//  inputs:
//           clk, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module air(
	input clk,
	input [4:0] temperature,
	output reg heating, cooling
	);
always @(posedge clk) begin
	case ({heating, cooling})
		2'b00: begin
			if (temperature >= 5'b11000)
				cooling = 1'b1;
			else
			if (temperature <= 5'b10010)
				heating = 1'b1;
			end
		2'b01: begin
			if (temperature <= 5'b10100)
				cooling = 1'b0;
			end
		2'b10: begin
			if (temperature >= 5'b10100)
				heating = 1'b0;
			end
		default: begin
			heating = 0;
			cooling = 0;
			end
	endcase
end
endmodule
				
		
