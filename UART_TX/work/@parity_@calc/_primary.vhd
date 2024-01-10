library verilog;
use verilog.vl_types.all;
entity Parity_Calc is
    generic(
        DATA_WIDTH      : integer := 8
    );
    port(
        P_Data          : in     vl_logic_vector;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        Data_Valid      : in     vl_logic;
        Par_type        : in     vl_logic;
        Par_bit         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
end Parity_Calc;
