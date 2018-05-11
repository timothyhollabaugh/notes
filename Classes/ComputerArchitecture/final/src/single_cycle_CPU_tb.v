module single_cycle_CPU_tb();
    reg clock, reset;

    initial
        clock <= 1'b0;

    always
        #5 clock <= ~clock;

    initial begin
        reset <= 1'b1;
        #12 reset <= 1'b0;
    end

    single_cycle_CPU dut(clock, reset);

    wire [7:0]R0, R1, R2, R3, R4, R5, R6, R7;
    wire [7:0]M4,M7;

    assign R0 = dut.reg_file0.reg_file[0];
    assign R1 = dut.reg_file0.reg_file[1];
    assign R2 = dut.reg_file0.reg_file[2];
    assign R3 = dut.reg_file0.reg_file[3];
    assign R4 = dut.reg_file0.reg_file[4];
    assign R5 = dut.reg_file0.reg_file[5];
    assign R6 = dut.reg_file0.reg_file[6];
    assign R7 = dut.reg_file0.reg_file[7];
    assign M4 = dut.ram_inst.mem[4];
    assign M7 = dut.ram_inst.mem[7];

    initial
        #200 $stop;

endmodule
