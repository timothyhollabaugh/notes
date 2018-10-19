module TimerTestBench();
    reg clock, reset;
    wire t;

    Timer timer (
        .clock(clock), 
        .reset(reset), 
        .t(t)
    );

    initial begin
        clock <= 1'b0;
        reset <= 1'b1;
    end

    always begin
        #5 clock <= ~clock;
    end

    always begin
        #10 reset <= 1'b0;
        #200 reset <= 1'b1;
    end

    initial begin
        #250 $stop;
    end

endmodule
