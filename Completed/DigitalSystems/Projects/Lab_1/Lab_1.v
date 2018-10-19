module Lab_1(SW, HEX0);
	input [6:0]SW;
	output [6:0]HEX0;
	// map the inputs directly to the outputs
	assign HEX0 = SW;
endmodule
