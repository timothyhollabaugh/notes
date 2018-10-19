module Stopwatch(CLOCK_50, BUTTON, HEX0, HEX1, HEX2, HEX3, HEX2_DP, LEDG);
    input CLOCK_50;
    input [2:0] BUTTON;

    output [6:0] HEX0;
    output [6:0] HEX1;
    output [6:0] HEX2;
    output [6:0] HEX3;
    output HEX2_DP;
    output [9:0] LEDG;

    wire clock_100hz;

    wire enable;
    wire reset;

    wire [15:0] digits;
    wire [6:0] hex0;
    wire [6:0] hex1;
    wire [6:0] hex2;
    wire [6:0] hex3;

    ClockDivider divider (
        .clock_in(CLOCK_50),
        .clock_out(clock_100hz)
    );

    Statemachine statemachine (
        .clock(clock_100hz),
        .start_button(~BUTTON[0]),
        .stop_button(~BUTTON[1]),
        .reset_button(~BUTTON[2]),
        .enable(enable),
        .reset(reset),
        .state(LEDG[1:0])
    );

    Dataflow dataflow (
        .enable(enable),
        .reset(reset),
        .clock(clock_100hz),
        .t(digits)
    );

    SevenSeg seg1 (
        .in(digits[3:0]),
        .out(hex0)
    );

    assign HEX0 = ~hex0;

    SevenSeg seg2 (
        .in(digits[7:4]),
        .out(hex1)
    );

    assign HEX1 = ~hex1;

    SevenSeg seg3 (
        .in(digits[11:8]),
        .out(hex2)
    );

    assign HEX2 = ~hex2;

    SevenSeg seg4 (
        .in(digits[15:12]),
        .out(hex3)
    );

    assign HEX3 = ~hex3;

    assign HEX2_DP = 0;

    assign LEDG[9] = clock_100hz;

endmodule


