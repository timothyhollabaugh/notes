library verilog;
use verilog.vl_types.all;
entity function_unit is
    port(
        FS              : in     vl_logic_vector(3 downto 0);
        A               : in     vl_logic_vector(7 downto 0);
        B               : in     vl_logic_vector(7 downto 0);
        F               : out    vl_logic_vector(7 downto 0);
        V               : out    vl_logic;
        C               : out    vl_logic;
        N               : out    vl_logic;
        Z               : out    vl_logic
    );
end function_unit;
