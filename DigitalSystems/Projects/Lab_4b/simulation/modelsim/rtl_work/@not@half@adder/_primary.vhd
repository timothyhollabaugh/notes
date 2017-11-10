library verilog;
use verilog.vl_types.all;
entity NotHalfAdder is
    port(
        A               : in     vl_logic;
        Cin             : in     vl_logic;
        S               : out    vl_logic;
        Cout            : out    vl_logic
    );
end NotHalfAdder;
