library verilog;
use verilog.vl_types.all;
entity zero_fill_contstant is
    port(
        IR_2_down_0     : in     vl_logic_vector(2 downto 0);
        \constant\      : out    vl_logic_vector(7 downto 0)
    );
end zero_fill_contstant;
