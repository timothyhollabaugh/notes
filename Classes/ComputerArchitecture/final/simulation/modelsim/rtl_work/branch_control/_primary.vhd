library verilog;
use verilog.vl_types.all;
entity branch_control is
    port(
        V               : in     vl_logic;
        C               : in     vl_logic;
        N               : in     vl_logic;
        Z               : in     vl_logic;
        PL              : in     vl_logic;
        JB              : in     vl_logic;
        BC              : in     vl_logic;
        ProgramCounterFunctionSelect: out    vl_logic_vector(1 downto 0)
    );
end branch_control;
