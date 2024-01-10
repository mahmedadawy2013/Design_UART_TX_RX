/******************************************************************************
*
* Module: Private - Serializer Block 
*
* File Name: Serializer.v
*
* Description:  This Block Is Used To Transform The Input Data From Parrlrl 
*               To Serial Data 
*
* Author: Mohamed A. Eladawy
*
*******************************************************************************/

//********************Port Declaration*************************//
module  Serializer # (

parameter INPUT_WIDTH   = 8 ) //initialize a parameter variable with value 8 
  
(

input wire [INPUT_WIDTH-1 : 0 ]  P_Data       ,  //Declaring the Variable As an Input Port with width 8 bits 
input wire                       Data_Valid   ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                       CLK          ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                       RST          ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                       Busy_Sir     ,  //Declaring the Variable As an Input Port with width 1 bit
input wire                       Ser_Enable   ,  //Declaring the Variable As an Input Port with width 1 bit
output wire                       Ser_Data     ,  //Declaring the Variable As an Input Port with width 1 bit
output wire                      Ser_Done        //Declaring the Variable As an output Port with width 1 bit    

); 
//****************** Parameeters Initialization  ****************//

localparam          ONE                    = 1'b1   ,//initialize a parameter variable with a binary value 1
                    ZERO                   = 1'b0   ,//initialize a parameter variable with a binary value 0
                    Serial_Register_width  = 8      ;//initialize a parameter variable with a binary value 8

//********************Internal Signal Declaration*****************//

reg [ Serial_Register_width-1 :0]  Serial_Register ;               //Declaring The Variable To Use it As a register Inside The Always Block
reg [2 : 0 ]                       Counter         ;
                    
//*************************** The RTL Code *****************************//
/*************** Starting The Combinational Always Block ***************/

always@( posedge CLK or negedge RST )

 begin
      
      if(!RST)
        
           begin
              
               Serial_Register <= 'b0 ;
                   
               
           end
           
       else if(Data_Valid &! Busy_Sir )
       
           begin 
            
              Serial_Register <= P_Data ;
              
           end
            
      else    if ( Ser_Enable ) 
           begin
             
   
              //Ser_Data        <= Serial_Register[7]      ;
              Serial_Register <= (Serial_Register<<1)    ;
              
           end
 
      end


always @(posedge CLK or negedge RST )

begin 
        if(!RST)
        
           begin
              
               Counter <= 'b0 ;
                   
               
           end
  
      else if ( Ser_Enable   ) 
        
        begin 
          
          Counter = Counter + 1 ; 
          
        end 
        
       else  
         
         Counter <= 'b0 ;
      
  
end 

assign Ser_Done = ( Counter == 3'b111 ) ; 
assign Ser_Data = Serial_Register[7] ; 
endmodule