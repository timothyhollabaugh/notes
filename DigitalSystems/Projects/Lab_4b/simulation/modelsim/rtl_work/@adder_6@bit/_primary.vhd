library verilog;
use verilog.vl_types.all;
entity Adder_6Bit is
    port(
        A               : in     vl_logic_vector(5 downto 0);
        B               : in     vl_logic_vector(5 downto 0);
        Cin             : in     vl_logic;
        Cout            : out    vl_logic;
        S               : out    vl_logic_vector(5 downto 0)
    );
end Adder_6Bit;
