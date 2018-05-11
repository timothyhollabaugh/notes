library verilog;
use verilog.vl_types.all;
entity data_memory is
    port(
        clock           : in     vl_logic;
        MW              : in     vl_logic;
        address         : in     vl_logic_vector(7 downto 0);
        data_in         : in     vl_logic_vector(7 downto 0);
        data_out        : out    vl_logic_vector(7 downto 0)
    );
end data_memory;
