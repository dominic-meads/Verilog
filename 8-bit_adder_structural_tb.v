`timescale 1ns / 1ps

module tb;
	reg [7:0] A;
	reg [7:0] B;
	wire [7:0] SUM;
	wire CARRY;
	
	_8_bit_adder uut(A,B,SUM,CARRY);
	
	initial 
		begin 
			//for EDAplayground only
			$dumpfile("dump.vcd");
			$dumpvars(0,uut);
			A=8'b01100100;    //d100
			B=8'b01111000;    //d120
			//result should be d220 or b11011100
			#1
			A=8'b00010001;    //d17
			B=8'b10000111;    //d135
			//result should be d152 or b10011000
			#1
			A=8'b11111111;    //d255
			B=8'b00000010;    //d2 
			//result should be d257 or b00000001 with CARRY = 1
			#1
			$finish;
		end 
endmodule 
			
