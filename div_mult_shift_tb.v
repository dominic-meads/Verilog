`timescale 1ns / 1ns 

module tb;
  reg [3:0] in;
 // wire [3:0] out;
  wire [4:0] out;
  
 // division uut(in,out);
  multiply uut(in,out);
  
  initial
    begin 
      $dumpfile("dump.vcd");
      $dumpvars(0,uut);
      in=4'b1010;
      #1
      in=4'b1110;
      #1
      $finish;
    end
endmodule 
