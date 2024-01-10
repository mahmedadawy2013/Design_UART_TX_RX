/******************************************************************************
*
* Module: Private - FSM Block 
*
* File Name: FSM.v
*
* Description:  This File Is Used To Make The Mux Enable For To Make The 
*               Fram And Output Busy Signal 
*               
* Author: Mohamed A. Eladawy
*
*******************************************************************************/
//************************** Port Declaration ********************************//

module FSM (

input      wire        CLK            , //Declaring the Variable As an Input Port with width 1 bit 
input      wire        RST            , //Declaring the Variable As an Input Port with width 1 bit 
input      wire        Data_Valid_Fsm , //Declaring the Variable As an Input Port with width 1 bit  
input      wire        Par_Enable     , //Declaring the Variable As an Input Port with width 1 bit
input      wire        SER_DONE       , //Declaring the Variable As an Input Port with width 1 bit
output     reg         SER_ENABLE     , //Declaring the Variable As an Input Port with width 1 bit    
output     reg         Busy           , //Declaring the Variable As an Output Port with width 1 bit 
output     reg  [1 :0] Mux_Sel          //Declaring the Variable As an Output Port with width 1 bit 

);

//******************** Parameters Initialization  ******************//

localparam          IDLE      = 3'b000  , //initialize a parameter variable As A first State   ( IDLE STATE )
                    Starting  = 3'b001  , //initialize a parameter variable As A Seconed State ( Starting STATE )
                    Transfer  = 3'b010  , //initialize a parameter variable As A Third State   ( Parity STATE )
                    parity    = 3'b011  , //initialize a parameter variable As A Third State   ( Parity STATE )
                    Ending    = 3'b100  , //initialize a parameter variable As A Fourth State  ( Ending STATE ) 
                    ONE       = 1'b1    , //initialize a parameter variable with a binary value 1
                    ZERO      = 1'b0    ; //initialize a parameter variable with a binary value 0
                    
//******************** Internal Signal Declaration *****************//

reg      [2:0]      current_state ,
                    next_state    ;
                    

//************************* The RTL Code ***************************//

/*************** Starting The Sequential Always Block ***************/

always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
    
       begin
 
          current_state <= IDLE ;
          
       end
  else
   
       begin
   
          current_state <= next_state ;
 
       end

 end

/*************** Starting The Combinational Always Block ***************/

always @ (*)
 
 
 begin
    Busy       = ZERO    ;
    Mux_Sel    = 2'b01   ;
    next_state = IDLE    ;
    SER_ENABLE = ZERO    ;
   case (current_state)
 
   IDLE   :  begin
             
              Busy    = ZERO ;
              
              if( Data_Valid_Fsm )
             
                begin
               
                   next_state = Starting  ;
               
                end
             
              else   
              
                begin
              
                   next_state = IDLE ;
              
                end  
             end
             
   Starting  :  begin
              
              Busy       = ONE       ;
              Mux_Sel    = 2'b00     ;
              
              next_state = Transfer  ;

                end
  
   Transfer  :  begin
              
              
              Busy       = ONE       ;
              Mux_Sel    = 2'b10     ;
              SER_ENABLE = ONE       ;
              SER_ENABLE = ONE       ;
              
     if ( SER_DONE ) 
             
         begin 
                
              if(Par_Enable)
               
                begin
               
                 next_state = parity  ;
               
                end
             
              else  
             
                begin
             
                 next_state = Ending  ;
             
                end 
                
          end 
          
        else 
              
              begin 
              
              next_state = Transfer  ;
              
              end        
             
             end

parity  :  begin
              
              Busy       = ONE     ;
              Mux_Sel    = 2'b11   ;
              next_state = Ending  ;
              
           end 

Ending  :  begin
              
              Busy       = ONE     ;
              Mux_Sel    = 2'b01   ;
              next_state = IDLE    ;
              SER_ENABLE = ZERO    ;

           end
default : 
             begin
             
                 next_state = IDLE  ;
                 Busy       = ZERO  ;
             
             end  
   endcase   
 end



/*********************************************************************/

endmodule

