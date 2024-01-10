/******************************************************************************
*
* Module: Private - Data Sampling Block 
*
* File Name: Data_Sampling.v
*
* Description:  This Block Is Used To Oversampling by 8: 
*               This means that the clock speed of UART_RX is 8 times the speed of UART_TX.
*               
* Author: Mohamed A. Eladawy
*
*******************************************************************************/

//********************Port Declaration*************************//
module  Data_Sampling # (

parameter INPUT_WIDTH    = 4 ,
parameter Number_Edges   = 4 ) //initialize a parameter variable with value 8 
  
(

input wire  [INPUT_WIDTH-1 : 0 ]  Pre_scale_Samp ,  //Declaring the Variable As an Input Port with width 4 bits 
input wire                        dat_samp_en    ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                        CLK            ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                        RST            ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                        RX_IN          ,  //Declaring the Variable As an input Port with width 1 bit
output reg                        Sampled_Bit    ,  //Declaring the Variable As an output Port with width 1 bit 
output reg  [Number_Edges-1 : 0 ] edge_cnt_Samp     //Declaring the Variable As an output Port with width 1 bit    

); 
//****************** Parameeters Initialization  ****************//

localparam          ONE            = 1'b1   ,//initialize a parameter variable with a binary value 1
                    ZERO           = 1'b0   ,//initialize a parameter variable with a binary value 0
                    Samp_width     = 3      ;//initialize a parameter variable with a binary value 3

//********************Internal Signal Declaration*****************//

reg [Samp_width-1 : 0 ]              Samp_Reg          ;
reg                                  Sampled_Bit_Comb  ;

//*************************** The RTL Code *****************************//
/*************** Starting The Sequential Always Block ***************/

always @(posedge CLK or negedge RST )

begin 
        if(!RST)
        
           begin
              
               Sampled_Bit <= 'b0 ;
                   
               
           end
  
      else if ( dat_samp_en   ) 
        
           begin 
          
               if ( edge_cnt_Samp == ( ((Pre_scale_Samp/2)-1 ) )     )
                 
                 begin 
                 
                   Samp_Reg[0] <=  RX_IN  ; 
                   
                 end 
                 
               else if (edge_cnt_Samp == ( (Pre_scale_Samp/2)) )
                                  
                 begin 
                 
                   Samp_Reg[1] <=  RX_IN  ; 
                   
                 end 
                 
               else if ( edge_cnt_Samp == ( ((Pre_scale_Samp/2)+1) ))
                                                   
                 begin 
                 
                   Samp_Reg[2] <=  RX_IN  ; 
                   
                 end
                  
          Sampled_Bit <= Sampled_Bit_Comb ;
          
       end 
        
        else  
         
           begin 
          
              Sampled_Bit <= 'b0 ;
          
           end 

       
         
end 
/*************** Starting The Combinational Always Block ***************/

always @(*)


begin 
  
Sampled_Bit_Comb = 1'b0   ; // intialize the Sampled Bit with zero  

case ( Samp_Reg )  


3'b000: 
          begin
        
           Sampled_Bit_Comb = ZERO ; 
        
          end 

3'b001 :
          begin 
          
          Sampled_Bit_Comb = ZERO ; 
          
          end  
          
3'b010 :
          begin 
            
          Sampled_Bit_Comb = ZERO ;    
            
          end  
 
3'b011 :
          begin 
          
          Sampled_Bit_Comb = ONE ;  
          
          end 
 
3'b100 :
          begin 
          
          Sampled_Bit_Comb = ZERO ;  
          
          end
3'b101 :
          begin 
          
          Sampled_Bit_Comb = ONE ;  
          
          end
3'b110 :
          begin 
          
          Sampled_Bit_Comb = ONE ;  
          
          end  
3'b111 :
          begin 
          
          Sampled_Bit_Comb = ONE ;  
          
          end       
default :
          begin 
            
          Sampled_Bit_Comb = ZERO ;
            
          end   
 
 endcase                    

end  
 
/*******************************************************************************/

endmodule


