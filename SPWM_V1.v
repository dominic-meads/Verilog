`default_nettype none
`timescale 1ns / 1ns
module top(
  input clk,
  output outa,
  output outb
);
  wire  out_to_outa;
  wire  out_to_outb;
  wire [1:0] count2_to_SEL1;
  wire [1:0] count1_to_SEL2;
  
  SPWM sp1(
    .clk (clk),
    .OUT (out_to_outa)
  );
  
  SPWM sp2(
    .clk (clk),
    .OUT (out_to_outb)
  );
  
  muxout mo1(
  .a (out_to_outa),
  .b (out_to_outb),
  .SEL1 (count2_to_SEL1),
  .SEL2 (count1_to_SEL2),
  .out1 (outa),
  .out2 (outb)
  );
  
    count2 c2(
    .clk (clk),
    .count2 (count2_to_SEL1)
  );
  
  count1 c1(
    .clk (clk),
    .count1 (count1_to_SEL2)
  );
  
  
endmodule 

module SPWM(
input clk, //reduced to one input and one output
output OUT
);

wire pwmout_to_muxa;
wire pwmout2_to_muxb;
wire pwmout3_to_muxc;
wire pwmout4_to_muxd;
wire pwmout5_to_muxe;
wire [2:0] select_to_SEL1; /*make sure wire is correct size vector*/
  
counter c1(
.clk_in (clk),
  .PWM1 (pwmout_to_muxa)
);
  
counter2 c21(
.clk_in2 (clk),
  .PWM2 (pwmout2_to_muxb)
);

counter3 c31(
.clk_in3 (clk),
  .PWM3 (pwmout3_to_muxc)
);
  
counter4 c41(
.clk_in4 (clk),
  .PWM4 (pwmout4_to_muxd)
);
  
counter5 c51(
  .clk_in5 (clk),
   .PWM5 (pwmout5_to_muxe)
);
  
mux m1(
  .a (pwmout_to_muxa),
  .b (pwmout2_to_muxb),
  .c (pwmout3_to_muxc),
  .d (pwmout4_to_muxd),
  .e (pwmout5_to_muxe),
  .sel1 (select_to_SEL1), //linking counter and the select
.out (OUT)
);
select s1(
  .clk (clk),
  .select (select_to_SEL1)
);

endmodule

module mux(
  input a,
  input b,
  input c,
  input d,
  input e,
  input [2:0] sel1, 
  output reg out 
);
  always @ (a or b or c or d or e or sel1) //always @ (*) means all inputs are included in sensititvity list IEEE verilog std 2001 
    begin 
      case(sel1)
         0 : out <= a;      
         1 : out <= b;
         2 : out <= c;
         3 : out <= d;
         4 : out <= e;
         
      endcase 
    end
endmodule

module counter(
  input clk_in,
  output reg[7:0] counter,
  output PWM1
);
  always @ (posedge clk_in)
    begin 
      if (counter <=255)
        counter <= counter +1;
      else
        counter <= 0;
    end
  assign PWM1 = (counter <23) ? 1:0;
  
endmodule

module counter2(
  input clk_in2,
  output reg[7:0] counter,
  output PWM2
);
  always @ (posedge clk_in2)
    begin 
      if (counter <=255)
        counter <= counter +1;
      else
        counter <= 0;
    end
  assign PWM2 = (counter <88) ? 1:0;
  
endmodule

module counter3(
  input clk_in3,
  output reg[7:0] counter,
  output PWM3
);
  always @ (posedge clk_in3)
    begin 
      if (counter <=255)
        counter <= counter +1;
      else
        counter <= 0;
    end
  assign PWM3 = (counter <164) ? 1:0;
  
endmodule

module counter4(
  input clk_in4,
  output reg[7:0] counter,
  output PWM4
);
  always @ (posedge clk_in4)
    begin 
      if (counter <=255)
        counter <= counter +1;
      else
        counter <= 0;
    end
  assign PWM4 = (counter <221) ? 1:0;
  
endmodule

module counter5(
  input clk_in5,
  output reg[7:0] counter,
  output PWM5
);
  always @ (posedge clk_in5)
    begin 
      if (counter <=255)
        counter <= counter +1;
      else
        counter <= 0;
    end
  assign PWM5 = (counter <251) ? 1:0;
endmodule 

module select(
  input clk,
  output [2:0] select
);
  
  wire up_dn_to_upordn;
  
  updown u1(
    .clk (clk),
    .upordn (up_dn_to_upordn),
    .SEL1 (select)
  );
  up_dn p1(
    .clk (clk),
    .up_dn (up_dn_to_upordn)
  );
  
endmodule

module updown(
  input clk,
  input upordn,
  output [2:0] SEL1
);
  reg [2:0] counter =0;
  
  always @ (posedge clk) 
    begin
      if (upordn ==1)
        begin
          counter <= #255000 counter +1; //make sure 1 clock cycles less?
        end
      if (upordn ==0)
        begin
          counter <= #255000 counter -1;
        end
    end
  assign SEL1 = counter;
endmodule

module up_dn(
  input clk,
  output up_dn
);
  reg [11:0] count  =0;
  always@(posedge clk)
    begin
      if (count <2047)
        count <= count +1;
      else 
        count <=0;
    end
  assign up_dn = (count <1024) ? 1:0;
endmodule 

module muxout(
  input a,
  input b,
  input [1:0] SEL1,
  input [1:0] SEL2,
  output reg out1,
  output reg out2  //declare as register for mux
);
  always @ (a or b or SEL1 or SEL2)
    begin 
      case(SEL1)
        0 : out1 <= a;
        1 : out1 <= 0;
      endcase              //you can have multiple cases. 
      case(SEL2)
        1 : out2 <= 0;
        0 : out2 <= b;
      endcase
    end
endmodule

module count1(
  input clk,
  output [1:0] count1
);
  reg [13:0] counter =0;
  always @ (posedge clk)
    begin
      if (counter <=4607)
        counter = counter +1;
      else 
        counter <=0;
    end 
  assign count1 = (counter <2305) ? 1:0;
endmodule

module count2(
  input clk,
  output [1:0] count2
);
  reg [13:0] counter =0;
  always @ (posedge clk)
    begin
      if (counter <=4607)
        counter = counter +1;
      else 
        counter <=0;
    end 
  assign count2 = (counter <2305) ? 0:1;
endmodule
