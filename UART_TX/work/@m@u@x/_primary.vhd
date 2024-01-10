library verilog;
use verilog.vl_types.all;
entity MUX is
    generic(
        Selction_Width  : integer := 2;
        Data_Size_C     : integer := 32
    );
    port(
        SEL             : in     vl_logic_vector;
        Ser_Data_Mux    : in     vl_logic;
        Parity_Bit      : in     vl_logic;
        TX_OUT          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Selction_Width : constant is 1;
    attribute mti_svvh_generic_type of Data_Size_C : constant is 1;
end MUX;
