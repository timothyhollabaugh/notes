module vga_test(LEDG, SWITCH);

    input [9:0] SWITCH;
    output [9:0] LEDG;

    assign LEDG = SWITCH;

endmodule
