/******************************************************************************
*
* Module: Private - Deserializer Block 
*
* File Name: Deserializer.v
*
* Description:  This Block Is Used To Deserialize the data to out the parllel data
*              
*               
* Author: Mohamed A. Eladawy
*
*******************************************************************************/

//********************Port Declaration*************************//
module  Deserializer # (

parameter Number_Edges   = 4 , 
parameter DATA_WIDTH     = 8 ) //Paramters Block
  
(

input wire                        Deser_EN            ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                        CLK                 ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                        RST                 ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                        Sampled_Bit_Deser   ,  //Declaring the Variable As an input Port with width 1 bit
input wire [Number_Edges-1 :0]    Edge_count          ,  //Declaring the Variable As an input Port with width 3 bit
output reg [DATA_WIDTH-1   :0]    P_Data_Deser           //Declaring the Variable As an output Port with width 1 bit 

); 
//****************** Parameeters Initialization  ****************//

localparam          ONE            = 1'b1   ,//initialize a parameter variable with a binary value 1
                    ZERO           = 1'b0   ;//initialize a parameter variable with a binary value 0
                    

//********************Internal Signal Declaration*****************//

reg [7:0]     P_Data_Deser_Comb ;  


//*************************** The RTL Code *****************************//
/*************** Starting The Sequential Always Block ***************/

always @(posedge CLK or negedge RST )

begin 
        if(!RST)
        
           begin
              
               P_Data_Deser <= 'b0 ;
                     
           end
  
      else if ( Deser_EN  && Edge_count == 3'b111  ) // && Edge_count == 3'b111 
        
           begin
            
            P_Data_Deser <=  {Sampled_Bit_Deser,P_Data_Deser[7:1]};
         
          end	
     else
      
      begin
        
         P_Data_Deser <= P_Data_Deser ;
      
      end 
end 


endmodule







