library verilog;
use verilog.vl_types.all;
entity program_counter is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        ProgramCounterFunctionSelect: in     vl_logic_vector(1 downto 0);
        JumpInput       : in     vl_logic_vector(7 downto 0);
        BranchInput     : in     vl_logic_vector(7 downto 0);
        PC              : out    vl_logic_vector(7 downto 0)
    );
end program_counter;
