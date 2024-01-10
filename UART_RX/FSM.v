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

input      wire        CLK                , //Declaring the Variable As an Input Port with width 1 bit 
input      wire        RST                , //Declaring the Variable As an Input Port with width 1 bit 
input      wire        PAR_EN_FSM         , //Declaring the Variable As an Input Port with width 1 bit  
input      wire        RX_IN_FSM          , //Declaring the Variable As an Input Port with width 1 bit
input      wire        STR_CHK_ERR_FSM    , //Declaring the Variable As an Input Port with width 1 bit 
input      wire        END_CHK_ERR_FSM    , //Declaring the Variable As an Input Port with width 1 bit
input      wire        PAR_CHK_ERR_FSM    , //Declaring the Variable As an Input Port with width 1 bit
input      wire [3:0]  BIT_Counts_FSM     , //Declaring the Variable As an Input Port with width 1 bit
input      wire [3:0]  EDGE_Counts_FSM    , //Declaring the Variable As an Input Port with width 1 bit
output     reg         STR_CHK_EN_FSM     , //Declaring the Variable As an Input Port with width 1 bit 
output     reg         END_CHK_EN_FSM     , //Declaring the Variable As an Input Port with width 1 bit
output     reg         PAR_CHK_EN_FSM     , //Declaring the Variable As an Input Port with width 1 bit  
output     reg         COUNTER_CHK_EN_FSM , //Declaring the Variable As an Input Port with width 1 bit 
output     reg         DATA_SAMP_EN_FSM   , //Declaring the Variable As an Input Port with width 1 bit 
output     reg         DESER_EN_FSM       , //Declaring the Variable As an Input Port with width 1 bit 
output     reg         Data_Valid_Fsm       //Declaring the Variable As an Input Port with width 1 bit  

);

//******************** Parameters Initialization  ******************//

localparam          IDLE      = 3'b000  , //initialize a parameter variable As A first State   ( IDLE STATE )
                    Starting  = 3'b001  , //initialize a parameter variable As A Seconed State ( Starting STATE )
                    Transfer  = 3'b011  , //initialize a parameter variable As A Third State   ( Parity STATE )
                    parity    = 3'b010  , //initialize a parameter variable As A Third State   ( Parity STATE )
                    Ending    = 3'b110  , //initialize a parameter variable As A Fourth State  ( Ending STATE )
                    ERR_CHECK = 3'b111  , //initialize a parameter variable As A Fourth State  ( Error STATE  )
                    Dat_VALID = 3'b101  , //initialize a parameter variable As A Fourth State  ( VALID STATE  )
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
  
  case(current_state)
 
  IDLE   : begin
           
           if( RX_IN_FSM )
			        
			         next_state = Starting ;
			     
			     else
			  
			         next_state = IDLE  ; 			
          
           end
  
  Starting  : begin
             
           if( BIT_Counts_FSM == 4'b0 && EDGE_Counts_FSM == 4'b111 )
			  
			     begin
			      
			       if(!STR_CHK_ERR_FSM)                  
				     
				         begin
			          
			             next_state = Transfer ;
                
                 end
            
             else 
                
                 begin
 			          
 			             next_state = IDLE ;       
                
                 end		
           end
			   else
			  
			      begin
			        
			         next_state = Starting ; 
			         			
           end			  
           end


  Transfer   : begin
            
                if(BIT_Counts_FSM == 4'd8 && EDGE_Counts_FSM == 4'b111)
			
			              begin
			               
			                  if(PAR_EN_FSM)
				                
				                  begin
			                      
			                       next_state = parity ;
				                  
				                  end 
                 else
				                  begin
			                     
			                     
			                       next_state = Ending ;
                
                          end					
                    end
			          else
			       
			               begin
			             
			                    next_state = Transfer ; 			
               
                     end			  
           end 
  parity : 
  
            begin
             
             if(BIT_Counts_FSM == 4'd9 && EDGE_Counts_FSM == 4'b111)
			       
			          begin
			   
			              next_state = Ending ; 
             
               end
			     else
			  
			         begin
			            
			             next_state = parity ; 			
			             
               end			  
           end
           
  Ending   : begin
              
              if(BIT_Counts_FSM == 4'd10 && EDGE_Counts_FSM == 3'd5)
		        // errors
		         	     begin
			  
			                 next_state = ERR_CHECK ; 
                   end
			      
			        else
			              begin
			               
			                 next_state = Dat_VALID ; 			
            
                    end			  
          
              end	
           
  ERR_CHECK   : begin
               
                  if(PAR_CHK_ERR_FSM | END_CHK_ERR_FSM)
			         
			                  begin
			          
			                      next_state = IDLE ; 
                       
                        end
			            else
			                  
			                  begin
			                    
			                     next_state = Dat_VALID ; 	    				
                        
                        end			  
                end	
  
  Dat_VALID : begin
              
                 if(!RX_IN_FSM)
			              
			              next_state = Starting ;
			           
			           else
			              
			              next_state = IDLE ; 						
           
             end			  		   
  
  default: begin
			 
			       next_state = IDLE ; 
          
          end	
  endcase                 	   
 end 

 
// output logic
always @ (*)
 begin
   STR_CHK_EN_FSM      = ZERO  ; 
   END_CHK_EN_FSM      = ZERO  ;
   PAR_CHK_EN_FSM      = ZERO  ; 
   COUNTER_CHK_EN_FSM  = ZERO  ;
   DATA_SAMP_EN_FSM    = ZERO  ;
   DESER_EN_FSM        = ZERO  ;
   Data_Valid_Fsm      = ZERO  ;     
  case(current_state)
  IDLE   : begin
             if(!RX_IN_FSM)
			  begin
               COUNTER_CHK_EN_FSM = ONE  ; 
               DESER_EN_FSM       = ZERO ; 
               PAR_CHK_EN_FSM     = ZERO ; 
               END_CHK_EN_FSM     = ZERO ;	
			         STR_CHK_EN_FSM     = ONE  ;
               DATA_SAMP_EN_FSM   = ONE  ; 			   
			  end 
			else
			  begin
			         STR_CHK_EN_FSM     = ONE  ;
               COUNTER_CHK_EN_FSM = ZERO ; 
               DESER_EN_FSM       = ZERO ; 
               PAR_CHK_EN_FSM     = ZERO ; 
               END_CHK_EN_FSM     = ZERO ;
               DATA_SAMP_EN_FSM   = ZERO ; 			   
			  end  			
           end
  Starting  : begin
			       STR_CHK_EN_FSM     = ONE  ;  
             COUNTER_CHK_EN_FSM = ONE  ; 
             DESER_EN_FSM       = ZERO ; 
             PAR_CHK_EN_FSM     = ZERO ;
             END_CHK_EN_FSM     = ZERO ;
             DATA_SAMP_EN_FSM   = ONE  ;			 
           end
  Transfer   : begin
             COUNTER_CHK_EN_FSM = ONE  ; 
             DESER_EN_FSM       = ONE  ; 
             PAR_CHK_EN_FSM     = ZERO ;
             END_CHK_EN_FSM     = ZERO ;
             DATA_SAMP_EN_FSM   = ONE  ;			 
           end
  parity : begin
             COUNTER_CHK_EN_FSM = ONE  ; 
             DESER_EN_FSM       = ZERO ; 
             PAR_CHK_EN_FSM     = ONE ;
             END_CHK_EN_FSM     = ZERO ;
             DATA_SAMP_EN_FSM   = ONE  ;				 
           end
  Ending   : begin
             COUNTER_CHK_EN_FSM = ONE  ; 
             DESER_EN_FSM       = ZERO ;  
             PAR_CHK_EN_FSM     = ZERO ; 
             END_CHK_EN_FSM     = ONE  ;
             DATA_SAMP_EN_FSM   = ONE  ;				 
           end	
  ERR_CHECK: begin
             COUNTER_CHK_EN_FSM = ZERO  ; 
             DESER_EN_FSM       = ZERO  ; 
             PAR_CHK_EN_FSM     = ZERO  ; 
             END_CHK_EN_FSM     = ZERO  ;
             DATA_SAMP_EN_FSM   = ONE   ;				 
           end	
  Dat_VALID:begin
             COUNTER_CHK_EN_FSM = ZERO  ;
             DESER_EN_FSM       = ZERO  ; 
             PAR_CHK_EN_FSM     = ZERO  ; 
             END_CHK_EN_FSM     = ZERO  ;
             Data_Valid_Fsm     = ONE   ; 
             DATA_SAMP_EN_FSM   = ZERO  ;				 
           end			   
  default: begin
   STR_CHK_EN_FSM      = ZERO  ; 
   END_CHK_EN_FSM      = ZERO  ;
   PAR_CHK_EN_FSM      = ZERO  ; 
   COUNTER_CHK_EN_FSM  = ZERO  ;
   DATA_SAMP_EN_FSM    = ZERO  ;
   DESER_EN_FSM        = ZERO  ;
   Data_Valid_Fsm      = ZERO  ;	 
		   end 
  endcase                 	   
 end 

endmodule
 