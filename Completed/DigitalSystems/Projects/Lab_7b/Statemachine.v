module Statemachine(clock, start_button, stop_button, reset_button, best_time_button, enable, reset_time, reset_best_time, display_time, display_best_time, update_best_time, compare, state);

    input clock, start_button, stop_button, reset_button, best_time_button, compare;
    output reg enable, reset_time, reset_best_time, display_time, display_best_time, update_best_time;

    parameter RESET_BEST_TIME   = 3'b000;
    parameter RESET_TIME        = 3'b001;
    parameter COUNTING          = 3'b010;
    parameter HOLD              = 3'b011;
    parameter NEW_BEST_TIME     = 3'b100;
    parameter DISPLAY_BEST_TIME = 3'b101;

    output reg [2:0] state;
    reg [2:0] next_state;

    // next state
    always @(state or start_button or stop_button or reset_button or best_time_button or compare) begin
        case(state)
            RESET_BEST_TIME: next_state <= RESET_TIME;
            RESET_TIME: next_state <= start_button ? COUNTING : RESET_TIME;
            COUNTING: next_state <= stop_button ? HOLD : (reset_button ? RESET_BEST_TIME : COUNTING);
            HOLD: begin
                if (reset_button) begin
                    next_state <= RESET_BEST_TIME;
                end else if (best_time_button) begin
                    if (compare) begin
                        next_state <= NEW_BEST_TIME;
                    end else begin
                        next_state <= DISPLAY_BEST_TIME;
                    end
                end else if (start_button) begin
                    next_state <= RESET_TIME;
                end else begin
                    next_state <= HOLD;
                end
            end
            NEW_BEST_TIME: next_state <= DISPLAY_BEST_TIME;
            DISPLAY_BEST_TIME: next_state <= reset_button ? RESET_BEST_TIME : (start_button ? RESET_TIME : DISPLAY_BEST_TIME);
            default: next_state <= RESET_BEST_TIME;
        endcase
    end

    // storage
    always @(posedge clock) begin
        state <= next_state;
    end

    // Outputs
    always @(state) begin
        case(state)
            RESET_BEST_TIME:   {enable, update_best_time, reset_time, reset_best_time, display_time, display_best_time} <= 6'b000110;
            RESET_TIME:        {enable, update_best_time, reset_time, reset_best_time, display_time, display_best_time} <= 6'b001010;
            COUNTING:          {enable, update_best_time, reset_time, reset_best_time, display_time, display_best_time} <= 6'b100010;
            HOLD:              {enable, update_best_time, reset_time, reset_best_time, display_time, display_best_time} <= 6'b000010;
            NEW_BEST_TIME:     {enable, update_best_time, reset_time, reset_best_time, display_time, display_best_time} <= 6'b010010;
            DISPLAY_BEST_TIME: {enable, update_best_time, reset_time, reset_best_time, display_time, display_best_time} <= 6'b000001;
            default: {enable, update_best_time, reset_time, reset_best_time, display_time, display_best_time} <= 6'b000010;
        endcase
    end
endmodule


