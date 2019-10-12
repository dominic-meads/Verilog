//source

module x(
  input in1,
  input in2,
  input ctrl,
  output out
);
  
//instantiations of primitve modules

and G(out1_to_in,in1,in2); //primitives included in Verilog, not VHDL
  //in form of and G(out,in1,in2);

wire out1_to_in; // connects output of AND to buffer. 

  bufif1 g(out,out1_to_in,ctrl); //tri state primitive, only enabled when ctrl high
  //in form of bufif1 g(out,in,ctrl);
  
endmodule





//testbench

module tb;
  reg in1,in2,ctrl;
  wire out;
  
  x uut(in1,in2,ctrl,out);
  
  initial 
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0,uut);
      
      in1=1;
      in2=0;
      ctrl=1;
      #1
      in1=1;
      in2=1;
      ctrl=1;
      #1
      in1=1;
      in2=1;
      ctrl=0; //buffer disabled, out = z (high impedance)
      #1 
      $finish;
    end
endmodule
