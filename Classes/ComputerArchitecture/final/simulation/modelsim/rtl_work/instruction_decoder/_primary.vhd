library verilog;
use verilog.vl_types.all;
entity instruction_decoder is
    port(
        IR              : in     vl_logic_vector(15 downto 0);
        DA              : out    vl_logic_vector(7 downto 0);
        AA              : out    vl_logic_vector(7 downto 0);
        BA              : out    vl_logic_vector(7 downto 0);
        MB              : out    vl_logic;
        FS              : out    vl_logic_vector(3 downto 0);
        MD              : out    vl_logic;
        RW              : out    vl_logic;
        MW              : out    vl_logic;
        PL              : out    vl_logic;
        JB              : out    vl_logic;
        BC              : out    vl_logic
    );
end instruction_decoder;
