`timescale 1ns / 1ns

module division(
  input [3:0] in,
  output [3:0] out
);
  
  assign out = in >> 1;
  /*like multiplication, to divide by 2, use >>1
  for divide by 4 use >>2
  for divide by 8 use >>3 */
  
endmodule 

module multiply(
  input [3:0] in,
  output [4:0] out
);
  
  assign out = in << 1;
  //to multiply by 4, use <<2
  //likewise, to multiply by 8, use <<3
  //make sure to add room for higher # of bits
  
endmodule 

/* overall message: to divide or multiply by powers of two, put the exponent to the left of the shift operator, and add bits module ports. 
*/
