`timescale 1ns / 1ps

module _8_bit_adder(
	input [7:0] A,
	input [7:0] B,
	output [7:0] SUM,
	output CARRY
	);
	
	wire w_C0,w_C1,w_C2,w_C3,w_C4,w_C5,w_C6;
	reg r_sum0,r_sum1,r_sum2,r_sum3,r_sum4,r_sum5,r_sum6,r_sum7;
	
	half_adder h0(
		.A(A[0]),
		.B(B[0]),
		.SUM(SUM[0]),
		.CARRY(w_C0)
		);
		
	full_adder f0(
		.A(A[1]),
		.B(B[1]),
		.C(w_C0),
		.SUM(SUM[1]),
		.CARRY(w_C1)
		);
	
	full_adder f1(
		.A(A[2]),
		.B(B[2]),
		.C(w_C1),
		.SUM(SUM[2]),
		.CARRY(w_C2)
		);
	
	full_adder f2(
		.A(A[3]),
		.B(B[3]),
		.C(w_C2),
		.SUM(SUM[3]),
		.CARRY(w_C3)
		);
	
	full_adder f3(
		.A(A[4]),
		.B(B[4]),
		.C(w_C3),
		.SUM(SUM[4]),
		.CARRY(w_C4)
		);
	
	full_adder f4(
		.A(A[5]),
		.B(B[5]),
		.C(w_C4),
		.SUM(SUM[5]),
		.CARRY(w_C5)
		);
		
	full_adder f5(
		.A(A[6]),
		.B(B[6]),
		.C(w_C5),
		.SUM(SUM[6]),
		.CARRY(w_C6)
		);
		
	full_adder f6(
		.A(A[7]),
		.B(B[7]),
		.C(w_C6),
		.SUM(SUM[7]),
		.CARRY(CARRY)
		);
	
endmodule

	
module full_adder(
	input A,B,C,
	output SUM,CARRY
	);
	
	wire w_half_adders;
	wire w_OR_A;
	wire w_OR_B;
	
	half_adder h0(
		.A(A),
		.B(B),
		.SUM(w_half_adders),
		.CARRY(w_OR_A)
		);
		
	half_adder h1(
		.A(w_half_adders),
		.B(C),
		.SUM(SUM),
		.CARRY(w_OR_B)
		);
		
	or(CARRY,w_OR_A,w_OR_B);
	
endmodule

module half_adder(
	input A, B,
	output SUM, CARRY
	);
	
	XOR x0(
		.A(A),
		.B(B),
		.Y(SUM)
		);
	
	and(CARRY,A,B);
	
endmodule 



module XOR(
  input A, B,
  output Y
);
  wire not_A;
  wire not_B;
  wire not_A_and_B;
  wire not_B_and_A; 
  
  NOT n1(
    .A(A),
    .Y(not_A)
  );  
  NOT n2(
    .A(B),
    .Y(not_B)
  );  
  AND a1(
    .A(not_A),
    .B(B),
    .Y(not_A_and_B)
  );
  AND a2(
    .A(A),
    .B(not_B),
    .Y(not_B_and_A)
  );  
  OR o1(
    .A(not_A_and_B),
    .B(not_B_and_A),
    .Y(Y)
  ); 
endmodule

module AND(
  input A, B,
  output Y
);
  and(Y,A,B);
endmodule


module NOT(
  input A,
  output Y
);
  not(Y,A);
endmodule


module OR(
  input A, B,
  output Y
);
  or(Y,A,B);
endmodule
