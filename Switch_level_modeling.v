`timescale 1ns / 1ps

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

