
// 4 input 1 output multiplexer
//https://www.chipverify.com/verilog/verilog-4to1-mux
`default_nettype none

module mux(
  input a,
  input b,
  input c,
  input d,
  input [1:0] sel1, //sel1 (2 bit) multiplexes the output
  output reg out //what is procedural block?
);
 // This always block gets executed whenever a/b/c/d/sel changes value
   // When that happens, based on value in sel, output is assigned to a/b/c/d
  always @ (sel1) //sensitive list
    begin 
      case(a or b or c or d or sel1) //use case statment to define diff. cases
        //alternativley, if dont care about inputs changing: case(sel1) works
        //case 1
         2'b00 : out <= a;
        //case 2
         2'b01 : out <= b;
        //case 3
         2'b10 : out <= c;
        //case 4
         2'b11 : out <= d; 
      endcase 
    end
endmodule
