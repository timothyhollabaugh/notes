module Timer(clock, reset, t);
    input clock;
    input reset;
    output t;

    wire [2:0] n;
    reg [2:0] p;

    // implement next state logic
    assign n[0] = ~p[0];
    assign n[1] = p[1] ^ p[0];
    assign n[2] = p[2] ^ (p[1] & p[0]);

    // implement output logic
    assign t = p[2] & p[1] & p[0];

    // implement storage with posistive reset
    always @(posedge clock or posedge reset) begin
        if(reset)
            p <= 3'b000;
        else
            p <= n;
    end

endmodule
