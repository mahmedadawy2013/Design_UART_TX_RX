library verilog;
use verilog.vl_types.all;
entity Serializer is
    generic(
        INPUT_WIDTH     : integer := 8
    );
    port(
        P_Data          : in     vl_logic_vector;
        Data_Valid      : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        Busy_Sir        : in     vl_logic;
        Ser_Enable      : in     vl_logic;
        Ser_Data        : out    vl_logic;
        Ser_Done        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of INPUT_WIDTH : constant is 1;
end Serializer;
