library verilog;
use verilog.vl_types.all;
entity Multiplexer is
    port(
        A               : in     vl_logic_vector(5 downto 0);
        B               : in     vl_logic_vector(5 downto 0);
        S               : in     vl_logic;
        \out\           : out    vl_logic_vector(5 downto 0)
    );
end Multiplexer;
