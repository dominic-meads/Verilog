`timescale 1ns / 1ps

/////////////////////////////////////////////////////////////////////////////////////////
//
//   PROJECT DESCRIPTION:	Useful for debouncing switches or button presses. If the 
//							switch goes from high to low, or low to high, the counter
//							will start counting. If bounce occurs during the transitions,
//							the counter will reset. Only when the input has been stable 
//							for a specified time (from counter) will the output change. 
//
//	            FILENAME:   switch_debounce.v
//	             VERSION:   1.0  6/9/2020
//                AUTHOR:   Dominic Meads 
//
/////////////////////////////////////////////////////////////////////////////////////////

module switch_debounce #(
		
		parameter TIME = 500000   /* amount of counts needed for a time of 4 ms to occur. The counter will count up as long as input is stable.
									 Basically when the input is stable for the above specified TIME parameter (125 MHz * 4ms), the output will follow */ 
		)(
		input clk,
		input i_in,    // switch, button, etc...
		input o_out    // stable and debounced output
		);
			
		// states for FSM
		localparam IDLE = 0;   // idle state
		localparam LTH = 1;    // switch goes from low to high
		localparam HTL = 2;    // switch goes from high to low
		
		reg [1:0] STATE = 0;   // register to keep track of the state
		
		reg r_out = 0;         // output register 
		
		// counter registers
		reg [31:0] counter = 0; // 32 bits so can specify a wide range of the TIME paramter
		reg count_enable = 0;   
		
		
		// always block to count
		always @ (posedge clk)
			begin 
				if (count_enable)
					begin 
						if (counter < TIME - 1)
							counter <= counter + 1;
						else 
							counter <= 0;
					end  // if (count...
				else  // if the count_enable is low
					counter <= 0;
			end  // always
		
		// state machine 
		always @ (posedge clk)
			begin 
				case (STATE)
					
					IDLE : begin   // IDLE is where the input is low, waiting to be switched or pressed (button)
							r_out <= 0;
							count_enable <= 0;
							if (i_in)  // if the input goes high
								STATE <= LTH;  // change state to the low to high (LTH) state
							else 
								STATE <= IDLE;  // else stay in the same state. 
						   end  // IDLE 
					
					LTH : begin 
							if (i_in) 
								begin 
									count_enable <= 1;  // enable counter
									if (counter == TIME - 1)  // if the counter reaches the full time
										begin
											r_out <= 1;  // the input is not bouncing anymore, so make output go high
											STATE <= HTL;  // change state to wait for when input switch goes back low
										end  // if (counter...
									else  // if counter doesn't reach full time
										begin 
											r_out <= 0;  // output not high
											STATE <= LTH;  // keep in same state 
										end  // else 
								end  // if (i_in)	
							else  // if i_in goes back low due to bounce
								begin 
									count_enable <= 0;  // reset counter
									r_out <= 0;
									STATE <= LTH;  // stay in same state 
								end  // else 
						  end  // LTH
						  
					HTL : begin 
							if (!i_in)
								begin 
									count_enable <= 1;  // enable counter
									if (counter == TIME - 1)  // if the counter reaches the full time
										begin
											r_out <= 0;  // the input is not bouncing anymore, so make output go low
											STATE <= IDLE;  // change state to wait for when input switch goes high again
										end  // if (counter...
									else  // if counter doesn't reach full time
										begin 
											r_out <= 1;  // output high
											STATE <= HTL;  // keep in same state 
										end  // else 
								end  // if (!i_in)	
							else  // if i_in goes back high due to bounce
								begin 
									count_enable <= 0;  // reset counter
									r_out <= 1;
									STATE <= HTL;  // stay in same state 
								end  // else 
						  end  // HTL 
						  
					default : begin 
								STATE <= IDLE;  // default state: wait for something to happen
								r_out <= 0;
								count_enable <= 0; 
							  end  // default 
				endcase
			end  // always 
			
		// output assignment 
		assign o_out = r_out;

endmodule  // switch_debounce
							
							
									
							
				
				
				
				
				
				
				
				
				
				
				
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
	
	