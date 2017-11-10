// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
// CREATED		"Thu Oct  5 18:51:50 2017"

module FiveBitAdderVerilog(
	A,
	B,
	Cout,
	S
);


input wire	[4:0] A;
input wire	[4:0] B;
output wire	Cout;
output wire	[4:0] S;

wire	[4:0] S_ALTERA_SYNTHESIZED;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;

assign	SYNTHESIZED_WIRE_0 = 0;




OneBitAdder	b2v_Bit1(
	.A(A[0]),
	.B(B[0]),
	.Cin(SYNTHESIZED_WIRE_0),
	.S(S_ALTERA_SYNTHESIZED[0]),
	.Cout(SYNTHESIZED_WIRE_1));


OneBitAdder	b2v_Bit2(
	.A(A[1]),
	.B(B[1]),
	.Cin(SYNTHESIZED_WIRE_1),
	.S(S_ALTERA_SYNTHESIZED[1]),
	.Cout(SYNTHESIZED_WIRE_2));


OneBitAdder	b2v_Bit3(
	.A(A[2]),
	.B(B[2]),
	.Cin(SYNTHESIZED_WIRE_2),
	.S(S_ALTERA_SYNTHESIZED[2]),
	.Cout(SYNTHESIZED_WIRE_3));


OneBitAdder	b2v_Bit4(
	.A(A[3]),
	.B(B[3]),
	.Cin(SYNTHESIZED_WIRE_3),
	.S(S_ALTERA_SYNTHESIZED[3]),
	.Cout(SYNTHESIZED_WIRE_4));


OneBitAdder	b2v_Bit5(
	.A(A[4]),
	.B(B[4]),
	.Cin(SYNTHESIZED_WIRE_4),
	.S(S_ALTERA_SYNTHESIZED[4]),
	.Cout(Cout));


assign	S = S_ALTERA_SYNTHESIZED;

endmodule
