library verilog;
use verilog.vl_types.all;
entity sign_extend_branch is
    port(
        IR_8_down_6     : in     vl_logic_vector(2 downto 0);
        IR_2_down_0     : in     vl_logic_vector(2 downto 0);
        BranchOffset    : out    vl_logic_vector(7 downto 0)
    );
end sign_extend_branch;
