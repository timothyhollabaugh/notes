library verilog;
use verilog.vl_types.all;
entity AddOne is
    port(
        A               : in     vl_logic;
        S               : out    vl_logic;
        Cout            : out    vl_logic
    );
end AddOne;
