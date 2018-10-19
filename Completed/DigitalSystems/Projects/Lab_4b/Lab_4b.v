
module AddOne(A, S, Cout);
	input A;
	output S;
	output Cout;
	
	assign S = A;
	assign Cout = ~A;
endmodule



module NotHalfAdder(A, Cin, S, Cout);
	input A;
	input Cin;
	output S;
	output Cout;
	
	assign S = ~A ^ Cin;
	assign Cout = ~A & Cin;

endmodule



module Complement(A, S);
	
	input [5:0]A;
	output [5:0]S;
	
	wire [5:0]Cout;
	
	AddOne add_one(
		.A(A[0]),
		.S(S[0]),
		.Cout(Cout[0])
	);
	
	NotHalfAdder not_half_adder1(
		.A(A[1]),
		.Cin(Cout[0]),
		.Cout(Cout[1]),
		.S(S[1])
	);
	
	NotHalfAdder not_half_adder2(
		.A(A[2]),
		.Cin(Cout[1]),
		.Cout(Cout[2]),
		.S(S[2])
	);
	
	NotHalfAdder not_half_adder3(
		.A(A[3]),
		.Cin(Cout[2]),
		.Cout(Cout[3]),
		.S(S[3])
	);
	
	NotHalfAdder not_half_adder4(
		.A(A[4]),
		.Cin(Cout[3]),
		.Cout(Cout[4]),
		.S(S[4])
	);
	
	NotHalfAdder not_half_adder5(
		.A(A[5]),
		.Cin(Cout[4]),
		.Cout(Cout[5]),
		.S(S[5])
	);
	
endmodule



module Multiplexer(A, B, S, out);
	input [5:0]A;
	input [5:0]B;
	input S;
	output [5:0]out;
	
	assign out[0] = (~S&A[0]) | (S&B[0]);
	assign out[1] = (~S&A[1]) | (S&B[1]);
	assign out[2] = (~S&A[2]) | (S&B[2]);
	assign out[3] = (~S&A[3]) | (S&B[3]);
	assign out[4] = (~S&A[4]) | (S&B[4]);
	assign out[5] = (~S&A[5]) | (S&B[5]);
	
endmodule



module SelectiveComplement(A, S, Comp);
	
	input [5:0]A;
	input S;
	output [5:0]Comp;
	
	wire [5:0]complement;
	
	Complement complementer(
		.A(A),
		.S(complement)
	);
	
	Multiplexer mux(
		.A(A),
		.B(complement),
		.S(S),
		.out(Comp)
	);
	
endmodule



module FullAdder(A, B, Cin, Cout, S);
	
	input A;
	input B;
	input Cin;
	output Cout;
	output S;
	
	assign Cout = (A & B) + ((A ^ B) & Cin);
	assign S = ((A ^ B) ^ Cin);
endmodule



module Adder_6Bit(A, B, Cin, Cout, S);
	
	input [5:0]A;
	input [5:0]B;
	input Cin;
	output Cout;
	output [5:0]S;
	
	wire [4:0]iCout;

	FullAdder bit1 (
		.A(A[0]),
		.B(B[0]),
		.Cin(Cin),
		.Cout(iCout[0]),
		.S(S[0])
	);

	FullAdder bit2 (
		.A(A[1]),
		.B(B[1]),
		.Cin(iCout[0]),
		.Cout(iCout[1]),
		.S(S[1])
	);

	FullAdder bit3 (
		.A(A[2]),
		.B(B[2]),
		.Cin(iCout[1]),
		.Cout(iCout[2]),
		.S(S[2])
	);

	FullAdder bit4 (
		.A(A[3]),
		.B(B[3]),
		.Cin(iCout[2]),
		.Cout(iCout[3]),
		.S(S[3])
	);

	FullAdder bit5 (
		.A(A[4]),
		.B(B[4]),
		.Cin(iCout[3]),
		.Cout(iCout[4]),
		.S(S[4])
	);

	FullAdder bit6 (
		.A(A[5]),
		.B(B[5]),
		.Cin(iCout[4]),
		.Cout(Cout),
		.S(S[5])
	);
	
endmodule

module Lab_4b(SW, BUTTON, LEDG, HEX0, HEX1, HEX2);
	
	input [9:0] SW;
	input [1:0] BUTTON;
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:6] HEX2;
	output [9:0] LEDG;
	
	wire [5:0] A;
	
	assign A[4:0] = SW[4:0];
	assign A[5] = 0;
	
	wire [5:0] Acomplement;
	
	SelectiveComplement ASelComp (
		.A(A),
		.S(~BUTTON[0]),
		.Comp(Acomplement)
	);
	
		
	wire [5:0] B;
	
	assign B[4:0] = SW[9:5];
	assign B[5] = 0;
	
	wire [5:0] Bcomplement;
	
	SelectiveComplement BSelComp (
		.A(B),
		.S(~BUTTON[1]),
		.Comp(Bcomplement)
	);
	
	wire [5:0] Sum;
	
	Adder_6Bit adder (
		.A(Acomplement),
		.B(Bcomplement),
		.Cin(0),
		.Cout(LEDG[0]),
		.S(Sum)
	);
	
	
	assign HEX2[6] = ~Sum[5];
	
	wire [7:0] SumComp;
	
	assign SumComp[6] = 0;
	assign SumComp[7] = 0;
	
	
	SelectiveComplement SumSelComp (
		.A(Sum),
		.S(Sum[5]),
		.Comp(SumComp[5:0])
	);
	
	wire [6:0]seg1;
	
	seven_seg digit1 (
		.in(SumComp[3:0]),
		.out(seg1)
	);
	
	assign HEX0 = ~seg1;
	
	wire [6:0]seg2;
	
	seven_seg digit2 (
		.in(SumComp[7:4]),
		.out(seg2)
	);
	
	assign HEX1 = ~seg2;
	
	assign LEDG[6:1] = Sum;
	
endmodule
