`timescale 1ns / 1ps

// checks to see if A is greater than B

module comparator_greater_than (
  input [3:0] i_A,
  input [3:0] i_B,
  output o_A_greater_than_B
);
  
  wire [3:0] w_B;
  
  assign w_B = i_B;
  assign o_A_greater_than_B = ((i_A | i_B) == w_B) ? 0:1;
endmodule
