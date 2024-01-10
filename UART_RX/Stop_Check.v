/******************************************************************************
*
* Module: Private - End Check Block 
*
* File Name: End_Check.v
*
* Description:  This Block Is Used To Check The End Bit of the frame
*              
*               
* Author: Mohamed A. Eladawy
*
*******************************************************************************/

//********************Port Declaration*************************//
module  End_Check # (
  
 ) //Paramters Block
  
(

input wire                        End_CHK_EN        ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                        CLK                 ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                        RST                 ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                        Sampled_Bit_End   ,  //Declaring the Variable As an input Port with width 1 bit
output reg                        End_Err              //Declaring the Variable As an output Port with width 1 bit 

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
              
               End_Err <= ZERO ;
                      
           end
  
      else if ( End_CHK_EN   ) 
        
           begin
            
               if ( Sampled_Bit_End == ONE ) 
                 
                 begin 
                   
                   End_Err = ZERO ; 
                   
                 end 
                 
              else 
                          
                 begin 
                   
                   End_Err = ONE ; 
                   
                 end 
          end	
end 

endmodule






