module Test ();
	reg [5:0]in;
	reg select;
	wire [5:0]out;

	SelectiveComplement selComp (
		.A(in[5:0]),
		.S(select),
		.Comp(out)
	);

	initial begin
		in <= 6'b000000;
		select <= 1'b0;
	end

	always begin
		#10
		in <= in + 6'b000001;
	end

	always begin
		#640
		select <= ~select;
	end

	initial begin
		#1500
		$stop;
	end
endmodule
