library verilog;
use verilog.vl_types.all;
entity mux_2_to_1 is
    generic(
        N               : integer := 8
    );
    port(
        S               : in     vl_logic;
        A               : in     vl_logic_vector;
        B               : in     vl_logic_vector;
        F               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end mux_2_to_1;
