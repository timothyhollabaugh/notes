module lab_1_testbench();
	// for a testbench inputs to the DUT are registers
	reg [6:0]switch;
	// and outputs of the DUT are wires
	wire [6:0]seven_seg;
	// instantiate a module use the module name followed by
	// the module identifier (typically DUT in this context)
	// then parenthesis with the input and output connections
	Lab_1 DUT (switch, seven_seg);
	// initialize the switch input to zero using an initial block
	// initial blocks run once when the FPGA starts
	// the begin and end keywords tell the compiler where
	// the block begins and ends
	initial begin
		switch <= 7'b0000000;
	end
	// always blocks run always
	always begin
		// delay 10 time steps (10 picoseconds by default)
		// note the delay command below only works in
		// ModelSim and not on real devices
		#10
		// increment the switch register by 1
		switch <= switch + 7'b0000001;
	end
	// after starting delay 1500 time steps then stop the simulation
	// otherwise the simulation would run until your computer
	// is out of memory
	initial begin
		#1500
		$stop;
	end
endmodule
