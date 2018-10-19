module Test (SW, BUTTON, LEDG);
	input [9:0]SW;
	input [2:0]BUTTON;
	output [9:0]LEDG;
	
	wire [5:0] A;
	
	assign A[4:0] = SW[4:0];
	assign A[5] = 0;
	
	wire [5:0] B;
	
	assign B[4:0] = SW[9:5];
	assign B[5] = 0;
	
	Multiplexer mux (
		.A(A),
		.B(B),
		.S(BUTTON[0]),
		.out(LEDG[5:0])
	);
	
	
	
endmodule