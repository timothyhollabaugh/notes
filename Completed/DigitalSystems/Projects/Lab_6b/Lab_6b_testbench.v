
module Lab_6b_testbench();
    reg clock, reset;
    wire rn, gn, yn, re, ge, ye, t;

    TrafficLight traffic_light (
        .clock(clock),
        .reset(reset),
        .t(t),
        .rn(rn),
        .gn(gn),
        .yn(yn),
        .re(re),
        .ge(ge),
        .ye(ye)
    );

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
        #500 reset <= 1'b1;
    end

    initial begin
        #550 $stop;
    end

endmodule