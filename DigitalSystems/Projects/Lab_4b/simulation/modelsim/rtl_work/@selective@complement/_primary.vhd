library verilog;
use verilog.vl_types.all;
entity SelectiveComplement is
    port(
        A               : in     vl_logic_vector(5 downto 0);
        S               : in     vl_logic;
        Comp            : out    vl_logic_vector(5 downto 0)
    );
end SelectiveComplement;
