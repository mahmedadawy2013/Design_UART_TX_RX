module UART_RX_tb ();



//Testbench Signals
reg                         RX_CLK_TB;
reg                         RST_TB;
reg                         RX_IN_TB;
reg   [3:0]                 Prescale_TB;
reg                         parity_enable_TB;
reg                         parity_type_TB;
wire  [7:0]                 P_DATA_TB; 
wire                        data_valid_TB;




//Initial 
initial
 begin

//initial values
RX_CLK_TB         = 1'b0   ;
RST_TB            = 1'b1   ;    // rst is deactivated
Prescale_TB       = 'd8 ;
parity_enable_TB  = 1'b1   ;
parity_type_TB    = 1'b0   ;
RX_IN_TB          = 1'b1   ;

//Reset the design
#2
RST_TB = 1'b0;    // rst is activated
#2
RST_TB = 1'b1;    // rst is deactivated
RX_IN_TB          = 1'b0   ; //start bit
#81
RX_IN_TB          = 1'b1   ; //1st bit
#80 
RX_IN_TB          = 1'b0   ; //2nd bit
#80 
RX_IN_TB          = 1'b0   ; //3rd bit
#80 
RX_IN_TB          = 1'b1   ; //4th bit
#80 
RX_IN_TB          = 1'b1   ; //5th bit
#80 
RX_IN_TB          = 1'b1   ; //6th bit
#80
RX_IN_TB          = 1'b0   ; //7th bit
#80
RX_IN_TB          = 1'b0   ; //8th bit
#80 
RX_IN_TB          = 1'b0   ; //parity bit
#80
RX_IN_TB          = 1'b1   ; //stop bit
#80  
#10000

$stop ;

end


 
 
// Clock Generator
always #5 RX_CLK_TB = ~RX_CLK_TB ;


// Design Instaniation
UART_RX DUT (
.CLK_UART_RX(RX_CLK_TB),
.RST_UART_RX(RST_TB),
.RX_IN_UART_RX(RX_IN_TB),
.Prescale_UART_RX(Prescale_TB),
.PAR_EN_UART_RX(parity_enable_TB),
.PAR_TYPE_UART_RX(parity_type_TB),
.P_DATA_UART_RX(P_DATA_TB), 
.DATA_VALId_UART_RX(data_valid_TB)
);

endmodule