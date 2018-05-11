library verilog;
use verilog.vl_types.all;
entity instruction_memory is
    port(
        address         : in     vl_logic_vector(7 downto 0);
        IR              : out    vl_logic_vector(15 downto 0)
    );
end instruction_memory;
