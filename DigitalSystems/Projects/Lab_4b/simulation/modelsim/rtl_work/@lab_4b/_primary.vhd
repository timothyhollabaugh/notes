library verilog;
use verilog.vl_types.all;
entity Lab_4b is
    port(
        SW              : in     vl_logic_vector(9 downto 0);
        BUTTON          : in     vl_logic_vector(1 downto 0);
        LEDG            : out    vl_logic_vector(9 downto 0);
        HEX0            : out    vl_logic_vector(6 downto 0);
        HEX1            : out    vl_logic_vector(6 downto 0);
        HEX2            : out    vl_logic_vector(6 downto 6)
    );
end Lab_4b;
