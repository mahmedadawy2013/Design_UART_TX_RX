/******************************************************************************
*
* Module: Private - Parity_Block
*
* File Name: Parity_Block.v
*
* Description:  This Block Is Used To Calculate The Fkn Even And Fkn Odd 
*               Parity
*               
* Author: Mohamed A. Eladawy
*
*******************************************************************************/
//************************** Port Declaration ********************************//

module Parity_Block # (

parameter INPUT_WIDTH   = 8 ) //initialize a parameter variable with value 8

(

input wire [INPUT_WIDTH-1 : 0 ]  P_Data       ,  //Declaring the Variable As an Input Port with width 8 bits 
input wire                       Data_Valid   ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                       CLK          ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                       RST          ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                       Par_Type     ,  //Declaring the Variable As an Input Port with width 1 bit
output reg                       Par_bit         //Declaring the Variable As an Input Port with width 1 bit

);

//******************** Parameters Initialization  ******************//

localparam          ONE                    = 1'b1   ,//initialize a parameter variable with a binary value 1
                    ZERO                   = 1'b0   ,//initialize a parameter variable with a binary value 0
                    Serial_Register_width  = 8      ;//initialize a parameter variable with a binary value 8

//********************Internal Signal Declaration*****************//

reg [ Serial_Register_width-1 :0]  Register_Parity ;               //Declaring The Variable To Use it As a register Inside The Always Block

//************************* The RTL Code ***************************//
/*************** Starting The Sequential Always Block ***************/

always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
    
       begin
 
          Register_Parity <= ZERO ;
          
       end
 
  else if ( Data_Valid ) 
   
       begin
   
          Register_Parity <= P_Data ;

       end
       
  else 
    
       if ( Par_Type )  
            
        begin
         
		 Par_bit <= ~^Register_Parity ;
      
 
       end  
       
       
     else 
       
       begin
   
            Par_bit <= ^Register_Parity ;
 
       end
       

 end





/*********************************************************************/

endmodule


