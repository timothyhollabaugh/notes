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
	
	// B = X'Z' + WY'Z + W'YZ + W'Y'Z' + W'X'
	
	wire XnZn, WYnZ, WnYZ, WnYnZn, WnXn;
	
	and and1 (XnZn, Xn, Zn);
	and and2 (WYnZ, W, Yn, Z);
	and and3 (WnYZ, Wn, Y, Z);
	and and4 (WnYnZn, Wn, Yn, Zn);
	and and5 (WnXn, Wn, Xn);
	
	or or1 (B, XnZn, WYnZ, WnYZ, WnYnZn, WnXn);
endmodule

module seg_C(in, C);
	input [3:0]in;
	output C;
	
	wire W, X, Y, Z;
	wire Wn, Xn, Yn, Zn;
	
	assign {W, X, Y, Z} = in;
	
	not not1 (Wn, W);
	not not2 (Xn, X);
	not not3 (Yn, Y);
	not not4 (Zn, Z);
	
	// C = w'y'+wx'+y'z+w'x+w'z
	
	wire WnYn, WXn, YnZ, WnX, WnZ;
	
	and and1 (WnYn, Wn, Yn);
	and and2 (WXn, W, Xn);
	and and3 (YnZ, Yn, Z);
	and and4 (WnX, Wn, X);
	and and5 (WnZ, Wn, Z);
	
	or or1 (C, WnYn, WXn, YnZ, WnX, WnZ);
endmodule

module seg_D(in, D);
	input [3:0]in;
	output D;
	
	wire W, X, Y, Z;
	wire Wn, Xn, Yn, Zn;
	
	assign {W, X, Y, Z} = in;
	
	not not1 (Wn, W);
	not not2 (Xn, X);
	not not3 (Yn, Y);
	not not4 (Zn, Z);
	
	// D = X'YZ+W'X'Z'+WY'Z'+XY'Z+XYZ'
	
	wire XnYZ, WnXnZn, WYnZn, XYnZ, XYZn;
	
	and and1 (XnYZ, Xn, Y, Z);
	and and2 (WnXnZn, Wn, Xn, Zn);
	and and3 (WYnZn, W, Yn, Zn);
	and and4 (XYnZ, X, Yn, Z);
	and and5 (XYZn, X, Y, Zn);
	
	or or1 (D, XnYZ, WnXnZn, WYnZn, XYnZ, XYZn);
endmodule

module seg_E(in, E);
	input [3:0]in;
	output E;
	
	wire W, X, Y, Z;
	wire Wn, Xn, Yn, Zn;
	
	assign {W, X, Y, Z} = in;
	
	not not1 (Wn, W);
	not not2 (Xn, X);
	not not3 (Yn, Y);
	not not4 (Zn, Z);
	
	// E = X'Z'+WY+YZ'+WX
	
	wire XnZn, WY, YZn, WX;
	
	and and1 (XnZn, Xn, Zn);
	and and2 (WY, W, Y);
	and and3 (YZn, Y, Zn);
	and and4 (WX, W, X);
	
	or or1 (E, XnZn, WY, YZn, WX);
endmodule

module seg_F(in, F);
	input [3:0]in;
	output F;
	
	wire W, X, Y, Z;
	wire Wn, Xn, Yn, Zn;
	
	assign {W, X, Y, Z} = in;
	
	not not1 (Wn, W);
	not not2 (Xn, X);
	not not3 (Yn, Y);
	not not4 (Zn, Z);
	
	// F = Y'Z'+W'XY'+XZ'+WX'+WY
	
	wire YnZn, WnXYn, XZn, WXn, WY;
	
	and and1 (YnZn, Yn, Zn);
	and and2 (WnXYn, Wn, X, Yn);
	and and3 (XZn, X, Zn);
	and and4 (WXn, W, Xn);
	and and5 (WY, W, Y);
	
	or or1 (F, YnZn, WnXYn, XZn, WXn, WY);
endmodule

module seg_G(in, G);
	input [3:0]in;
	output G;
	
	wire W, X, Y, Z;
	wire Wn, Xn, Yn, Zn;
	
	assign {W, X, Y, Z} = in;
	
	not not1 (Wn, W);
	not not2 (Xn, X);
	not not3 (Yn, Y);
	not not4 (Zn, Z);
	
	// G = X'Y+YZ'+W'XY'+WZ+WX'
	
	wire XnY, YZn, WnXYn, WZ, WXn;
	
	and and1 (XnY, Xn, Y);
	and and2 (YZn, Y, Zn);
	and and3 (WnXYn, Wn, X, Yn);
	and and4 (WZ, W, Z);
	and and5 (WXn, W, Xn);
	
	or or1 (G, XnY, YZn, WnXYn, WZ, WXn);
endmodule


module hex_to_seven_seg_structural(in, out);
	input [3:0]in;
	output [6:0]out;
	
	wire A, B, C, D, E, F, G;
	
	seg_A inst1 (in, A);
	seg_B inst2 (in, B);
	seg_C inst3 (in, C);
	seg_D inst4 (in, D);
	seg_E inst5 (in, E);
	seg_F inst6 (in, F);
	seg_G inst7 (in, G);
	
	assign out = {G, F, E, D, C, B, A};
endmodule






module hex_to_seven_seg_dataflow(in, out);
	input [3:0]in;
	output [6:0]out;
	
	wire A, B, C, D, E, F, G;
	wire W, X, Y, Z;
	
	assign {W, X, Y, Z} = in;
	
	// A = X'Z' + WX'Y' + W'XZ + WZ' + XY + W'Y
	assign A = ~X & ~Z | W & ~X & ~Y | ~W & X & Z | W & ~Z | X & Y | ~W & Y;
	
	// B = X'Z' + WY'Z + W'YZ + W'Y'Z' + W'X'
	assign B = ~X & ~Z | W & ~Y & Z | ~W & Y & Z | ~W & ~Y & ~Z | ~W & ~X;
	
	// C = w'y'+wx'+y'z+w'x+w'z
	assign C = ~W & ~Y | W & ~X | ~Y & ~X | ~Y & Z | ~W & X | ~W & Z;
	
	//     D =  X'  Y   Z +  W'   X'   Z'+ W    Y'   Z'+ X    Y'  Z + X   Y    Z'
	assign D = ~X & Y & Z | ~W & ~X & ~Z | W & ~Y & ~Z | X & ~Y & Z | X & Y & ~Z;
	
	//     E =  X'   Z'+ W   Y + Y    Z'+ W   X
	assign E = ~X & ~Z | W & Y | Y & ~Z | W & X;
	
	// F = Y'Z'+W'XY'+XZ'+WX'+WY
	assign F = ~Y & ~Z | ~W & X & ~Y | X & ~Z | W & ~X | W & Y;
	
	// G = X'Y+YZ'+W'XY'+WZ+WX'
	assign G = ~X & Y | Y & ~Z | ~W & X & ~Y | W & Z | W & ~X;
	
	assign out = {G, F, E, D, C, B, A};
	
endmodule






module hex_to_seven_seg_behavioral(in, out);
	input [3:0]in;
	output reg [6:0]out;
	
	always @(in) begin
		//4'b0000
		// <= Nonblocking
		// =  Blocking
		case (in)
			// WXYZ            GFEDCBA
			
			4'b0000: out <= 7'b0111111;
			4'b0001: out <= 7'b0000110;
			4'b0010: out <= 7'b1011011;
			4'b0011: out <= 7'b1001111;
			
			4'b0100: out <= 7'b1100110;
			4'b0101: out <= 7'b1101101;
			4'b0110: out <= 7'b1111101;
			4'b0111: out <= 7'b0000111;
			
			4'b1000: out <= 7'b1111111;
			4'b1001: out <= 7'b1100111;
			4'b1010: out <= 7'b1110111;
			4'b1011: out <= 7'b1111100;
			
			4'b1100: out <= 7'b0111001;
			4'b1101: out <= 7'b1011110;
			4'b1110: out <= 7'b1111001;
			4'b1111: out <= 7'b1110001;
			
		endcase
	end
endmodule






module Lab_3b(SW, BUTTON, HEX0, HEX1, HEX2);
	input [9:0]SW;
	input [2:0]BUTTON;
	
	output [6:0]HEX0, HEX1, HEX2;
	
	wire [6:0] seven_seg_out_structural, seven_seg_out_dataflow, seven_seg_out_behavioral;
	
	assign HEX0 = ~seven_seg_out_structural;
	assign HEX1 = ~seven_seg_out_dataflow;
	assign HEX2 = ~seven_seg_out_behavioral;
	
	hex_to_seven_seg_structural inst1 (SW[3:0], seven_seg_out_structural);
	hex_to_seven_seg_dataflow inst2 (SW[7:4], seven_seg_out_dataflow);
	hex_to_seven_seg_behavioral inst3 ({2'b00, SW[9:8]}, seven_seg_out_behavioral);
endmodule
