//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Lights Selector
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex7 - Lights Selector
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
    );    
parameter CLK_PERIOD = 10;

reg rst;
reg button;
reg clk;
reg error;
reg sel;

wire [23:0] light;
reg [23:0] prev_light;

initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

initial begin
    rst=1;
    button=0;
    error = 0;
    sel = 0;
    #(CLK_PERIOD)
    if (light != 24'hffffff) begin
        $display("TEST FAILED!");
        error = 1;
    end
    sel = 1;
    #(3*CLK_PERIOD)
    if (light != 24'hff) begin
        $display("TEST FAILED!");
        error = 1;
    end
    prev_light = light;
    rst = 0;
    #(CLK_PERIOD)
    if (light != prev_light) begin
        $display("TEST FAILED!");
        error = 1; 
    end
    #(CLK_PERIOD)
    forever begin
        prev_light = light;
        button = 1;
        #(CLK_PERIOD)
        button = 0;
        #(CLK_PERIOD)
        if (light == prev_light) begin
            $display("TEST FAILED!");
            error = 1;
        end
    end
end
initial begin
        #(50*CLK_PERIOD)
        if (error==0)
          $display("TEST PASSED!");
        $finish;
      end
lights_selector top (
   .rst (rst),
   .button (button),
   .clk (clk),
   .sel(sel),
   .light (light)
);
endmodule 
