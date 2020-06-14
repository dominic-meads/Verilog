`timescale 1ns / 1ps

module tb;
  reg A,B;
  wire Y;
  
  NANDgate uut(A,B,Y);
  
  initial 
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0,uut);
      A=0;
      B=1;
      #1
      A=1;
      B=0;
      #1
      A=1;
      B=1;
      #1
      $finish;
    end
endmodule
