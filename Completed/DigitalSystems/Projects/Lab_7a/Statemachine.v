module Statemachine(clock, start_button, stop_button, reset_button, enable, reset, state);

    input clock, start_button, stop_button, reset_button;
    output reg enable, reset;

    parameter RESET_STATE = 2'b00;
    parameter STOP_STATE = 2'b01;
    parameter START_STATE = 2'b10;

    output reg [1:0] state;
    reg [1:0] next_state;

    // next state
    always @(state or start_button or stop_button or reset_button) begin
        case(state)

            RESET_STATE: next_state <= STOP_STATE;

            STOP_STATE: begin
                if (reset_button) begin
                    next_state <= RESET_STATE;
                end else if (start_button) begin
                    next_state <= START_STATE;
                end else begin
                    next_state <= STOP_STATE;
                end
            end

            START_STATE: begin
                if (reset_button) begin
                    next_state <= RESET_STATE;
                end else if (stop_button) begin
                    next_state <= STOP_STATE;
                end else begin
                    next_state <= START_STATE;
                end
            end

            default: next_state <= STOP_STATE;

        endcase
    end

    // storage
    always @(posedge clock) begin
        state <= next_state;
    end

    // Outputs
    always @(state) begin
        case(state)
            RESET_STATE: {enable, reset} <= 2'b01;
            STOP_STATE:  {enable, reset} <= 2'b00;
            START_STATE: {enable, reset} <= 2'b10;
        endcase
    end


endmodule


