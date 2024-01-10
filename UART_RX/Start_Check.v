/******************************************************************************
*
* Module: Private - Start Check Block 
*
* File Name: Start_Check.v
*
* Description:  This Block Is Used To Check The Start Bit of the frame
*              
*               
* Author: Mohamed A. Eladawy
*
*******************************************************************************/

//********************Port Declaration*************************//
module  Start_Check # (
  
 ) //Paramters Block
  
(

input wire                        Start_CHK_EN        ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                        CLK                 ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                        RST                 ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                        Sampled_Bit_Start   ,  //Declaring the Variable As an input Port with width 1 bit
output reg                        Start_Err              //Declaring the Variable As an output Port with width 1 bit 

); 
//****************** Parameeters Initialization  ****************//

localparam          ONE            = 1'b1   ,//initialize a parameter variable with a binary value 1
                    ZERO           = 1'b0   ;//initialize a parameter variable with a binary value 0
                    

//********************Internal Signal Declaration*****************//



//*************************** The RTL Code *****************************//
/*************** Starting The Sequential Always Block ***************/

always @(posedge CLK or negedge RST )

begin 
        if(!RST)
        
           begin
              
               Start_Err <= ZERO ;
                      
           end
  
      else if ( Start_CHK_EN   ) 
        
           begin
            
               if ( Sampled_Bit_Start == ZERO ) 
                 
                 begin 
                   
                   Start_Err = ZERO ; 
                   
                 end 
                 
              else 
                          
                 begin 
                   
                   Start_Err = ONE ; 
                   
                 end 
          end	
end 

endmodule





