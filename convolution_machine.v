`timescale 1ns / 1ps

/* makes a convolution between x[n] = {0, 1, 2, 1, 0},
and the impulse response h[n] = {0, 1, 3, 2} */

module convolution_machine(
  input clk,
  input [1:0] signal,
  output [3:0] convolution
);
  
  // set registers to zero for low-side padding
  reg [1:0] xn = 2'b00;    // xn_y = x[n-z]
  reg [1:0] xn_1 = 2'b00;
  reg [1:0] xn_2 = 2'b00;
  reg [1:0] xn_3 = 2'b00;
  
  // impulse response registers
  reg [1:0] h0 = 2'b00;
  reg [1:0] h1 = 2'b01;
  reg [1:0] h2 = 2'b11;
  reg [1:0] h3 = 2'b10;
  
  // sum registers
  reg [3:0] s1;
  reg [3:0] s2;
  reg [3:0] s3;
  
  // output reg
  reg [3:0] r_out;
  
  reg [1:0] sum0 = 2'b00; // anything * 0 = 0;
  
  // combinational logic block for multiply and sum
  always @ (*)
    begin 
      s1 = MAC(xn_1, h1, sum0);
      s2 = MAC(xn_2, h2, s1);
      s3 = MAC(xn_3, h3, s2);
      r_out = s3;
    end 
  
  // sequential pipeline
  always @ (posedge clk)
    begin
      xn <= signal;
      xn_1 <= xn;
      xn_2 <= xn_1;
      xn_3 <= xn_2;
    end 
          
  // MAC function
      function [3:0] MAC;
        input [1:0] in, delta;
        input [3:0] sum;
        reg [3:0] mult;
        begin 
          mult = in * delta; // multiplies input by the impulse response coeff
          MAC = mult + sum;
        end 
      endfunction
  
  assign convolution = r_out;
  
endmodule 
