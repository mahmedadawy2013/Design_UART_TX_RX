/******************************************************************************
*
* Module: Private - Parity Check Block 
*
* File Name: Parity_Check.v
*
* Description:  This Block Is Used To Check The Parity of the Message
*              
*               
* Author: Mohamed A. Eladawy
*
*******************************************************************************/

//********************Port Declaration*************************//
module  Parity_Check # (
  
parameter DATA_WIDTH = 8 ) //Paramters Block
  
(

input wire                        PAR_TYP             ,  //Declaring the Variable As an Input Port with width 1 bit
input wire  [DATA_WIDTH-1:0]      P_DATA_Par          ,  //Declaring the Variable As an Input Port with width 8 bits  
input wire                        PAR_CHK_EN          ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                        CLK                 ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                        RST                 ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                        Sampled_Bit_par_chk ,  //Declaring the Variable As an input Port with width 1 bit
output reg                        PAR_ERR                //Declaring the Variable As an output Port with width 1 bit 

); 
//****************** Parameeters Initialization  ****************//

localparam          ONE            = 1'b1   ,//initialize a parameter variable with a binary value 1
                    ZERO           = 1'b0   ;//initialize a parameter variable with a binary value 0
                    

//********************Internal Signal Declaration*****************//

reg                 parity_Checker      ; //initialize a reg variable with a binary value 1

//*************************** The RTL Code *****************************//
/*************** Starting The Sequential Always Block ***************/

always @(posedge CLK or negedge RST )

begin 
        if(!RST)
        
           begin
              
               PAR_ERR <= ZERO ;
                      
           end
  
      else if ( PAR_CHK_EN   ) 
        
           begin
            
               PAR_ERR <= parity_Checker ^	Sampled_Bit_par_chk ;
         
          end	
end 
/*************** Starting The Combinational Always Block ***************/

always @(*)

  begin
    
    case(PAR_TYP)
   
    1'b0 : 
          begin                 
	       
	           parity_Checker <= ^P_DATA_Par  ;     // Even Parity
	       
	       end
   
    1'b1 : 
         
         begin
	           
	           parity_Checker <= ~^P_DATA_Par ;     // Odd Parity
	      
	       end		
 
    endcase       	 
 end 
 
/*******************************************************************************/

endmodule




