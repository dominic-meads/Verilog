
`timescale 1ns / 1ns

module testbench;
  reg [3:0] d;
  wire [3:0] q3;
  reg clk;
  
  always #4 clk = ~clk;
  
  pipeline uut(q3,d,clk);
  
  initial 
    begin 
      $dumpfile("dump.vcd");
      $dumpvars(0,uut);
      d=4'b1111;
      clk=0;
      #100
      $finish;
    end
endmodule
