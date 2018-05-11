library verilog;
use verilog.vl_types.all;
entity register_file8x8 is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        RW              : in     vl_logic;
        DA              : in     vl_logic_vector(2 downto 0);
        AA              : in     vl_logic_vector(2 downto 0);
        BA              : in     vl_logic_vector(2 downto 0);
        D               : in     vl_logic_vector(7 downto 0);
        A               : out    vl_logic_vector(7 downto 0);
        B               : out    vl_logic_vector(7 downto 0)
    );
end register_file8x8;
