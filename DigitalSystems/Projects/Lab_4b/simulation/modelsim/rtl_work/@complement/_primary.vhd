library verilog;
use verilog.vl_types.all;
entity Complement is
    port(
        A               : in     vl_logic_vector(5 downto 0);
        S               : out    vl_logic_vector(5 downto 0)
    );
end Complement;
