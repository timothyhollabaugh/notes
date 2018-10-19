module seg_A(in, A);
	input [3:0]in;
	output A;
	
	wire W, X, Y, Z;
	wire Wn, Xn, Yn, Zn;
	
	assign {W, X, Y, Z} = in;
	
	not not1 (Wn, W);
	not not2 (Xn, X);
	not not3 (Yn, Y);
	not not4 (Zn, Z);
	
	// A = X'Z' + WX'Y' + W'XZ + WZ' + XY + W'Y
	
	wire XnZn, WXnYn, WnXZ, WZn, XY, WnY;
	
	and and1 (XnZn, Xn, Zn);
	and and2 (WXnYn, W, Xn, Yn);
	and and3 (WnXZ, Wn, X, Z);
	and and4 (WZn, W, Zn);
	and and5 (XY, X, Y);
	and and6 (WnY, Wn, Y);
	
	or or1 (A, XnZn, WXnYn, WnXZ, WZn, XY, WnY);
endmodule

module seg_B(in, B);
	input [3:0]in;
	output B;
	
	wire W, X, Y, Z;
	wire Wn, Xn, Yn, Zn;
	
	assign {W, X, Y, Z} = in;
	
	not not1 (Wn, W);
	not not2 (Xn, X);
	not not3 (Yn, Y);
	not not4 (Zn, Z);
	
	// b = X'Z' + WY'Z + W'YZ + W'Y'Z' + W'X'
	
	wire XnZn, WYnZ, WnYZ, WnYnZn, WnXn;
	
	and and1 (XnZn, Xn, Zn);
	and and2 (WYnZ, W, Yn, Z);
	and and3 (WnYZ, Wn, Y, Z);
	and and4 (WnYnZn, Wn, Yn, Zn);
	and and5 (WnXn, Wn, Xn);
	
	or or1 (B, XnZn, WYnZ, WnYZ, WnYnZn, WnXn);
endmodule

module hex_to_seven_seg_structural(in, out);
	input [3:0]in;
	output [6:0]out;
	
	wire A, B, C, D, E, F, G;
	
	seg_A inst1 (in, A);
	seg_b inst2 (in, B);
	
	assign out = {G, F, E, D, C, B, A};
endmodule
