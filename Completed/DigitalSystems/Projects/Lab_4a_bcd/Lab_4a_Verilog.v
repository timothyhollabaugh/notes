module Lab_4a_Verilog(SW, HEX0, HEX1);
	input [9:0]SW;
	output [6:0]HEX0;
	output [6:0]HEX1;
	
	wire [7:0]sum;
	
	FiveBitAdder five_bit_adder (
		.A(SW[4:0]),
		.B(SW[9:5]),
		.Cout(sum[5]),
		.S(sum[4:0])
	);
	
	assign sum[6] = 0;
	assign sum[7] = 0;
	
	wire [3:0]bcd1;
	wire [3:0]bcd2;
	
	
	
	FiveBitAdder bcd_adder1 (
		.A(bcd1),
		.B((A | B | (D & (E | F))))
	);
	
	wire [6:0]out1;
	wire [6:0]out2;
	
	seven_seg seven_seg1 (
		.in(sum[3:0]),
		.out(out1[6:0]),
	);
	
	seven_seg seven_seg2 (
		.in(sum[7:4]),
		.out(out2[6:0]),
	);
	
	assign HEX0 = ~out1;
	assign HEX1 = ~out2;
	
endmodule

module subtract_10 (in, out);
	input [3:0]in;
	output [3:0]out;
	
	assign out[0] = ~in[0];
	assign out[1] = ~in[1];
	assign out[2] = ~(in[2]^in[3]);
	assign out[3] = 0;
	
endmodule
	