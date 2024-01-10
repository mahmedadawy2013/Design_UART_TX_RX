/******************************************************************************
*
* Module: Private - UART Transmiter Block
*
* File Name: UART_TX_tb.v
*
* Description:  this file is used for testing implementation of the UART Transmiter
*
* Author: Mohamed A. Eladawy
*
*******************************************************************************/
module  UART_TX_tb  () ;
  

// all design inputs are defined in testbench as reg to be used inside initial block 
// all design outputs are defined in testbench as wire   
  reg              RST_tb             ;
  reg              CLK_tb             ;
  reg   [7:0]      P_DATA_UART_tb     ;
  reg              DATA_VALID_UART_tb ;  
  reg              PAR_EN_UART_tb     ;
  reg              PAR_TYPE_UART_tb   ;
  wire             TX_OUT_UART        ;  
  wire             BUSY_UART          ;  

/***********************************************************************/ 
initial 
  begin
    $dumpfile(" UART_TX.vcd") ;
    $dumpvars ;
    //initial values
    RST_tb     = 1'b0     ;
    CLK_tb     = 1'b0     ;
    P_DATA_UART_tb = 8'b0 ;
    DATA_VALID_UART_tb = 1'b0 ; 
    PAR_EN_UART_tb = 1'b0     ;
   
/***********************************************************************/    
   
    $display ("TEST CASE 1") ;  // 
    #2
    RST_tb     = 1'b0  ;
    DATA_VALID_UART_tb = 1'b0 ; 
    #2
    RST_tb             = 1'b1         ;
    P_DATA_UART_tb     = 8'b1110_0110 ;
    DATA_VALID_UART_tb = 1'b1         ;
    PAR_EN_UART_tb     = 1'b1         ;
    PAR_TYPE_UART_tb   = 1'b1         ;
    #10
     DATA_VALID_UART_tb = 1'b0         ;
    #40
    DATA_VALID_UART_tb = 1'b1         ;
    #10 
    DATA_VALID_UART_tb = 1'b0         ;
    #60
    P_DATA_UART_tb     = 8'b1101_0010 ;
    DATA_VALID_UART_tb = 1'b1         ;
    PAR_EN_UART_tb     = 1'b1         ;
    PAR_TYPE_UART_tb   = 1'b1         ;
    #10
     DATA_VALID_UART_tb = 1'b0         ;
    #200

/***********************************************************************/    
       

    #100
    $finish ;  
  
      
end 

// Clock Generator  
  always #5 CLK_tb = !CLK_tb ;
  
// instaniate design instance 
 UART_TX DUT (

.CLK_UART(CLK_tb)                      ,
.RST_UART(RST_tb)                      ,
.P_DATA_UART(P_DATA_UART_tb)           ,
.DATA_VALID_UART(DATA_VALID_UART_tb)   ,
.PAR_EN_UART(PAR_EN_UART_tb)           ,
.PAR_TYPE_UART(PAR_TYPE_UART_tb)       ,
.BUSY_UART(BUSY_UART)                  ,
.TX_OUT_UART(TX_OUT_UART)

);

  
endmodule
  
