//SOURCE

module NANDgate(
  input A,
  input B,
  output Y
);
  supply1 VDD;
  supply0 VSS;
  
  wire between;
  //cmos(drain,source,gate)
  pmos(Y,VDD,A),(Y,VDD,B);
  nmos(Y,between,A),(between,VSS,B);
endmodule






//TESTBENCH

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
