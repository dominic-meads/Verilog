`timescale 1ns / 1ps

module comparator_greater_than_tb;
  reg [3:0] i_A;
  reg [3:0] i_B;
  wire o_A_greater_than_B;
  
  comparator_greater_than uut(
    .i_A(i_A),
    .i_B(i_B),
    .o_A_greater_than_B(o_A_greater_than_B)
  );
  
  task display_if_greater;
    input [3:0] i_A;
    input [3:0] i_B;
    input o_A_greater_than_B;
    begin 
      if (o_A_greater_than_B)
        $display("%d is greater than %d",i_A,i_B);
      else 
        $display("%d is less than %d",i_A,i_B);
    end
  endtask
      
  
  initial 
    begin 
      $dumpfile("dump.vcd");
      $dumpvars(0,uut);
      i_A = 4'd15;
      i_B = 4'd0;
      #2
      display_if_greater(i_A,i_B,o_A_greater_than_B);
      #2
      i_A = 4'd5;
      i_B = 4'd4;
      #2
      display_if_greater(i_A,i_B,o_A_greater_than_B);
      #2
      i_A = 4'd11;
      i_B = 4'd3;
      #2
      display_if_greater(i_A,i_B,o_A_greater_than_B);
      #2
      i_A = 4'd2;
      i_B = 4'd10;
      #2
      display_if_greater(i_A,i_B,o_A_greater_than_B);
      #2
      i_A = 4'd8;
      i_B = 4'd9;
      #2
      display_if_greater(i_A,i_B,o_A_greater_than_B);
      #2
      $finish;
    end
endmodule
