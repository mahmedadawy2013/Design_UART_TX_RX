library verilog;
use verilog.vl_types.all;
entity UART_TX is
    generic(
        Data_Width      : integer := 8
    );
    port(
        P_DATA_UART     : in     vl_logic_vector;
        DATA_VALID_UART : in     vl_logic;
        PAR_EN_UART     : in     vl_logic;
        PAR_TYPE_UART   : in     vl_logic;
        RST_UART        : in     vl_logic;
        CLK_UART        : in     vl_logic;
        TX_OUT_UART     : out    vl_logic;
        BUSY_UART       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Data_Width : constant is 1;
end UART_TX;
