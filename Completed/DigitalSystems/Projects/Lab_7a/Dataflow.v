module Dataflow(enable, reset, clock, t);

    input enable, reset, clock;
    output [15:0] t;

    wire enable1, enable2, enable3;

    BCD_4bit counter0 (
        .clock(clock),
        .enable(enable),
        .reset(reset),
        .t(t[3:0])
    );

    assign enable1 = enable & t[0] & t[3];

    BCD_4bit counter1 (
        .clock(clock),
        .enable(enable1),
        .reset(reset),
        .t(t[7:4])
    );

    assign enable2 = enable1 & t[4] & t[7];

    BCD_4bit counter2 (
        .clock(clock),
        .enable(enable2),
        .reset(reset),
        .t(t[11:8])
    );

    assign enable3 = enable2 & t[8] & t[11];

    BCD_4bit counter3 (
        .clock(clock),
        .enable(enable3),
        .reset(reset),
        .t(t[15:12])
    );

endmodule
