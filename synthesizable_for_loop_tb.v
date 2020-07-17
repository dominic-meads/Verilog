`timescale 1ns / 1ps

module tb;
  reg clk1;
  wire [3:0] o_shift1;
  
  always #10 clk1 = ~clk1;
  
  for_loop_example uut(.clk(clk1),.o_shift(o_shift1));
  
  initial
    begin 
      $dumpfile("test.vcd");
      $dumpvars(0,uut);
      clk1 = 0;
      #200
   $display("after exiting loop, shift reg = %b", o_shift1);
      $finish;
    end
endmodule 
