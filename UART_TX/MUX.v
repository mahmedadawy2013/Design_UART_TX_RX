/******************************************************************************
* Module: Private - MUX Block 
*
* File Name: MUX.v
*
* Description: implement a parameterized 4X1 MUX.
*
* Author: Mohamed A. Eladawy
*
*******************************************************************************/
//********************Port Declaration*************************//

module MUX  #(

parameter Selction_Width = 2  ,                                //initialize a parameter variable with value 32 
parameter Data_Size_C    = 32 )                                //initialize a parameter variable with value 32 

(
  
input wire [Selction_Width-1 :0]           SEL          , //Declaring the Variable As an Input Port with Width 2 bit
input wire                                 Ser_Data_Mux , //Declaring the Variable As an Input Port with Width 1 bits
input wire                                 Parity_Bit   , //Declaring the Variable As an Input Port with Width 1 bits
output reg                                 TX_OUT         //Declaring the Variable As an Output Port with Width 1 bits    

);

//******************** Parameters Initialization  ******************//

localparam          ONE      = 1'b1   , //initialize a parameter variable with a binary value 1
                    ZERO     = 1'b0   , //initialize a parameter variable with a binary value 0
                    Start    = 2'b00  , //initialize a parameter variable with a binary value 2'b00
                    stop     = 2'b01  , //initialize a parameter variable with a binary value 2'b01
                    ser_data = 2'b10  , //initialize a parameter variable with a binary value 2'b10
                    Parity   = 2'b11  ; //initialize a parameter variable with a binary value 2'b10
                                       
//*************************** The RTL Code *****************************//
//**************** Starting Combinational Always Block *****************//

always @ (*)

begin 

    case (SEL) 
    
    Start  :  begin
              
              TX_OUT = ZERO ; 
              
              end 
                  
    stop  :  begin
              
              TX_OUT = ONE ; 
              
              end 
                                
    ser_data  :  begin
              
              TX_OUT = Ser_Data_Mux ; 
              
              end 
              
    Parity  :  begin
              
              TX_OUT = Parity_Bit ; 
              
              end                  
       
      
    endcase
 
end 

//**********************************************************************//

endmodule    

