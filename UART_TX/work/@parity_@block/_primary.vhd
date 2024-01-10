library verilog;
use verilog.vl_types.all;
entity Parity_Block is
    generic(
        INPUT_WIDTH     : integer := 8
    );
    port(
        P_Data          : in     vl_logic_vector;
        Data_Valid      : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        Par_Type        : in     vl_logic;
        Par_bit         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of INPUT_WIDTH : constant is 1;
end Parity_Block;
