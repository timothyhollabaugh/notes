module BCD_4bit(clock, enable, reset, t);
    input clock, enable, reset;
    output [3:0] t;

    reg [3:0] state;
    wire [3:0] next_state;

    // Next state logic
    assign next_state[0] = ~reset & (state[0] ^ enable);
    assign next_state[1] = ~reset & ((enable & ((state[1] & ~state[0]) | (~state[3] & ~state[1] & state[0]))) | (state[1] & ~enable));
    assign next_state[2] = ~reset & (state[2] ^ (enable & state[0] & state [1]));
    assign next_state[3] = ~reset & ((enable & ((state[3] & ~state[0]) | (state[2] & state[1] & state[0]))) | (state[3] & ~enable));

    // Output logic
    assign t = state;

    // Move next state into state every clock
    always @(posedge clock) begin
        state <= next_state;
    end

endmodule

