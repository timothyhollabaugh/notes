module ClockDivider(clock_in, clock_out);
    input clock_in;
    output reg clock_out;

    reg [23:0] count;

    always @(posedge clock_in) begin
        count <= count + 1;

        if (count >= 24'd500000) begin
            count <= 24'd0;
        end

        clock_out <= (count > 24'd250000) ? 1'b1 : 1'b0;

    end
endmodule
