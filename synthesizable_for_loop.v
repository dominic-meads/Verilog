`timescale 1ns / 1ps

module for_loop_example(
  input clk,
  output [3:0] o_shift
);
  integer i=0;
  reg [3:0] r_shift = 4'b0001;
  
  always @ (posedge clk)
    begin 
      for(i = 0; i < 3; i=i + 1)
        r_shift[i+1] <= r_shift[i];   //make sure to use non-blocking
    end 
  assign o_shift = r_shift;
endmodule
