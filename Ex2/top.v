//////////////////////////////////////////////////////////////////////////////////
// Exercise #2 - Doorbell Chime
// Student Name: Mihnea Constantin
// Date: 14/06/21
//
//  Description: In this exercise, you need to design a multiplexer that chooses between two sounds, where the  
//  output is delayed by 5 ticks (not clocks!) and acts according to the following truth table:
//
//  sel | out
// -----------------
//   0  | a
//   1  | b
//
//  inputs:
//           a, b, sel
//
//  outputs:
//           out
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module doorbell(
	input a,
	input b, 
	input sel,
	output out
    //Todo: define inputs here
    );
    
    //Todo: define registers and wires here
	wire out;

    //Todo: define your logic here                 
      assign #5 out = (sel) ? b : a; //if sel is 1 assign out to a 
//else sel is 0 assign out to b
endmodule
