module vram (address, address2, in, in2, write, write2, out, out2, clock);

    input [7:0] in, in2;
    input [63:0] address, address2;
    input write, write2, clock;
    output reg [7:0] out, out2;

    // Declare the RAM variable
    reg [7:0] ram[7200:0];

    always @ (posedge clock) begin // Port A
        if (write) begin
            ram[address] <= in;
            out <= in;
        end else begin
            out <= ram[address];
        end
    end

    always @ (posedge clock) begin // Port b
        if (write2) begin
            ram[address2] <= in2;
            out2 <= in2;
        end
        else begin
            out2 <= ram[address2];
        end
    end
endmodule

/*(address, clock, in, write, out, address2, out2);
    input [12:0] address;
    input [12:0] address2;
    input clock;
    input [7:0] in;
    input write;

    output reg [7:0] out;
    output reg [7:0] out2;

    parameter memory_words = 7200;

    reg [7:0] mem [0:memory_words-1];

    always @ (posedge clock) begin
        if (write) begin
            mem[address] <= in;
        end

        if (!write) begin
            out <= mem[address];
        end

        out2 <= mem[address2];
    end
    endmodule*/
