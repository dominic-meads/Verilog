`timescale 1ns / 1ps

module tb;
	reg clk, i_switch;
	wire o_switch;
	
	always #4 clk = ~clk;  // 125 MHz clk from Arty Z7-10 board
	
	switch_debounce uut(clk,i_switch,o_switch);
	
	initial 
		begin 
			$dumpfile("dump.vcd");
			$dumpvars(0,uut);
			clk = 0;
			i_switch = 0;
			#500000
			i_switch = 1;
			#2000
			i_switch = 0;
			#6000
			i_switch = 1;  // rapidly switching simulates bounce
			#2000
			i_switch = 0;
			#10000
			i_switch = 1;
			#2000
			i_switch = 0;
			#10000
			i_switch = 1;
			#10000
			i_switch = 0;
			#2000
			i_switch = 1;
			#1000
			i_switch = 1;
			#1000
			i_switch = 0;
			#3000
			i_switch = 1;
			#1000
			i_switch = 0;
			#2000
			i_switch = 1;
			#5000
			i_switch = 0;
			#5000
			i_switch = 1;  // switch is now stable high
			#8000000
			i_switch = 0;
			#6000
			i_switch = 1;  // rapidly switching simulates bounce
			#2000
			i_switch = 0;
			#10000
			i_switch = 1;
			#2000
			i_switch = 0;
			#10000
			i_switch = 1;
			#10000
			i_switch = 0;
			#2000
			i_switch = 1;
			#1000
			i_switch = 1;
			#1000
			i_switch = 0;
			#3000
			i_switch = 1;
			#1000
			i_switch = 0;
			#2000
			i_switch = 1;
			#5000
			i_switch = 0;  // switch is now stable low
			#10000000
			$finish;
		end 
	endmodule  // tb;