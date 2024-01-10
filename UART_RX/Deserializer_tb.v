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
module  Deserializer_tb  () ;
  

// all design inputs are defined in testbench as reg to be used inside initial block 
// all design outputs are defined in testbench as wire   
reg                        Deser_EN_tb            ;  //Declaring the Variable As an Input Port with width 1 bit
reg                        CLK_tb                 ;  //Declaring the Variable As an Input Port with width 1 bit
reg                        RST_tb                 ;  //Declaring the Variable As an Input Port with width 1 bit
reg                        Sampled_Bit_Deser_tb   ;  //Declaring the Variable As an input Port with width 1 bit
reg  [2 :0]    Edge_count_tb         ;  //Declaring the Variable As an input Port with width 3 bit
wire [7 :0]   P_Data_Deser_tb        ;  //Declaring the Variable As an output Port with width 1 bit 

/***********************************************************************/ 
initial 
  begin
    $dumpfile(" Deserializer.vcd") ;
    $dumpvars ;
    //initial values
    RST_tb     = 1'b0     ;
    CLK_tb     = 1'b0     ;
    Sampled_Bit_Deser_tb = 1'b0 ;

   
/***********************************************************************/    
   
    $display ("TEST CASE 1") ;  // 
    #2
    RST_tb      = 1'b0  ;
    Deser_EN_tb = 1'b0  ; 
    #2
    RST_tb               = 1'b1         ;
    Deser_EN_tb          = 1'b1         ; 
    Sampled_Bit_Deser_tb = 1'b0         ;// at 4 0
    Edge_count_tb = 3'b111 ; 
    #6                              
    Sampled_Bit_Deser_tb = 1'b0         ; // at 10 0
    #10  
    Sampled_Bit_Deser_tb = 1'b1         ;  //at 20 1
    #10
    Sampled_Bit_Deser_tb = 1'b1         ;  //at 30  1 
    #10
    Sampled_Bit_Deser_tb = 1'b1         ; //at 40 1 
    #10
    Sampled_Bit_Deser_tb = 1'b0         ; //at 50 0 
    #10
    Sampled_Bit_Deser_tb = 1'b1         ; // at 60 1 
    #10
    Sampled_Bit_Deser_tb = 1'b1         ; // at 70 1 
    #10
    Deser_EN_tb          = 1'b0         ; 
/***********************************************************************/    
       

    #100
    $finish ;  
  
      
end 

// Clock Generator  
  always #5 CLK_tb = !CLK_tb ;
  
// instaniate design instance 
 Deserializer DUT (

.Deser_EN(Deser_EN_tb)                      ,
.CLK(CLK_tb)                      ,
.RST(RST_tb)           ,
.Sampled_Bit_Deser(Sampled_Bit_Deser_tb)   ,
.Edge_count(Edge_count_tb)           ,
.P_Data_Deser(P_Data_Deser_tb)      

);

  
endmodule
  
