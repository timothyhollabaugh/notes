module Lab_6b(LEDG, BUTTON, CLOCK_50);
    input CLOCK_50;
    input [2:0] BUTTON;
    output [9:0] LEDG;

    wire clock_4hz;
    wire t;

    ClockDivider u1 (
        .clk_in(CLOCK_50),
        .clk_out(clock_4hz)
    );

    Timer u2 (
        .clock(clock_4hz),
        .reset(~BUTTON[2]),
        .t(t)
    );

    TrafficLight u3 (
        .clock(clock_4hz),
        .reset(~BUTTON[2]),
        .t(t),
        .rn(LEDG[2]),
        .gn(LEDG[0]),
        .yn(LEDG[1]),
        .re(LEDG[5]),
        .ge(LEDG[3]),
        .ye(LEDG[4])
    );

    assign LEDG[9] = t;
    assign LEDG[8] = clock_4hz;

endmodule

