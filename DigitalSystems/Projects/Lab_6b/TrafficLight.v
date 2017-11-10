module TrafficLight(clock, reset, t, rn, gn, yn, re, ge, ye);
    input clock, reset, t;
    output reg rn, gn, yn, re, ge, ye;

    parameter R1 = 3'b000, GR = 3'bb001, YR = 3'b010, R2 = 3'b011, RG = 3'b100, RY = 3'b101;

    reg [2:0] state;
    reg [2:0] next_state;

    // next state
    always @(state or t) begin
        case(state)
            R1: next_state <= t ? GR : R1;
            GR: next_state <= t ? YR : GR;
            YR: next_state <= t ? R2 : YR;
            R2: next_state <= t ? RG : R2;
            RG: next_state <= t ? RY : RG;
            RY: next_state <= t ? R1 : RY;
            default: next_state <= GR;
        endcase
    end

    // storage
    always @(posedge clock or posedge reset) begin
        if(reset) begin
            state <= R1;
        end
        else begin
            state <= next_state;
        end
    end

    // outputs
    always @(state) begin
        case(state)
            R1: {rn, yn, gn, re, ye, ge} = 6'b100100;
            GR: {rn, yn, gn, re, ye, ge} = 6'b001100;
            YR: {rn, yn, gn, re, ye, ge} = 6'b010100;
            R2: {rn, yn, gn, re, ye, ge} = 6'b100100;
            RG: {rn, yn, gn, re, ye, ge} = 6'b100001;
            RY: {rn, yn, gn, re, ye, ge} = 6'b100010;
            default: {rn, gn, yn, re, ge, ye} = 6'b111111;
        endcase
    end

endmodule
