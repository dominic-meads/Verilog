
`timescale 1ns / 1ps

module tb;
  reg clk;
  reg [1:0] signal;
  wire [3:0] convolution;
  
  initial 
    begin 
      forever #5 clk = ~clk;
    end
  
  convolution_machine uut(clk,signal,convolution);
  
  initial 
    begin 
      $dumpfile("dump.vcd");
      $dumpvars(0,uut);
      clk = 0;
      signal = 2'b00; 
      #10
      signal = 2'b01;
      #10 
      signal = 2'b10;
      #10
      signal = 2'b01;
      #10 
      signal = 2'b00;
      #10
      signal = 2'b00;  // pads high zeros after sampling period ends
      #10
      signal = 2'b00;
      #10
      signal = 2'b00;
      #20
      $finish;
    end
endmodule
