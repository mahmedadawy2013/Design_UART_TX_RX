library verilog;
use verilog.vl_types.all;
entity FSM is
    port(
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        Data_Valid_Fsm  : in     vl_logic;
        Par_Enable      : in     vl_logic;
        SER_DONE        : in     vl_logic;
        SER_ENABLE      : out    vl_logic;
        Busy            : out    vl_logic;
        Mux_Sel         : out    vl_logic_vector(1 downto 0)
    );
end FSM;
