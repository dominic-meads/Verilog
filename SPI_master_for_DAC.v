//source

module SPI_master(
	input clk, 
	input DV,
	input [15:0] i_write_command,
    input arm,
  	output CS,
	output SPI_clk,
	output MOSI,
    output DV
	);
	
	wire w_SPI_clk;
	wire w_CS;
	
	SPI_clk s1(
		.clk(clk),
		.SPI_clk(SPI_clk)
		);
		
	SPI_clk s2(
		.clk(clk),
      .SPI_clk(w_SPI_clk)
		);
		
    CS_SM c1(                     //this CS for the serial to paralell
		.DV(DV),
		.clk(clk),
      .SPI_clk(w_SPI_clk),
		.CS(w_CS)
		);
  
    CS_SM c2(                     //this CS is for output
		.DV(DV),
		.clk(clk),
      .SPI_clk(w_SPI_clk),
        .CS(CS)
		);
		
	SPI_serial_parallel p1(
      .SPI_clk(w_SPI_clk),
		.i_write_command(i_write_command),
		.CS(w_CS),
		.MOSI(MOSI)
		);
		
	endmodule


module CS_SM(
  input DV,
  input clk,
  input SPI_clk,
  output CS
);
  
  localparam active = 1'b1;
  localparam inactive = 1'b0;
  
  reg r_SM;
  reg r_CS =1;
  reg [4:0] sck_counter =0;
  reg [2:0] ick_counter =0;
  
  always @ (posedge clk)
    begin 
      if (ick_counter <=4)
        ick_counter <= ick_counter +1;
      else
        ick_counter <=0;
    end
  
  always @ (negedge SPI_clk)
    begin
      if (sck_counter <=16)
        sck_counter <= sck_counter +1;
      else 
        sck_counter <= 0;
    end
  
  
  always @ (posedge clk)
    begin 
      
      case(r_SM)
        
        inactive: 
          
          begin 
          	if (r_CS & DV)
            	begin 
              		r_CS <= 1'b0; //drives active
                    sck_counter <=0;
                    ick_counter <=0;
              		r_SM <= active;
                end
          end
        
        active:
          
          begin 
            if(!r_CS && sck_counter==17)
              begin 
                if (ick_counter ==2)
                  begin 
                    r_CS <= 1'b1;
                    sck_counter <=0;
                    ick_counter <=0;
                    r_SM <= inactive;
                  end
              end
          end
        
        default:
          begin 
            r_CS <= 1'b1;
            sck_counter <=0;
            ick_counter <=0;
            r_SM <= inactive; 
          end
      endcase
    end
  
  assign CS = r_CS;
endmodule


module SPI_serial_parallel(
  input SPI_clk,
  input [15:0] i_write_command,
  input CS,
  output MOSI
);
  
  reg [15:0] r_write_command;
  reg [4:0] r_bit_number = 16; 
  reg r_MOSI;
 
always @ (negedge SPI_clk)
	begin 
      r_write_command <= i_write_command;
		if (!CS)
			begin 
              r_MOSI <= r_write_command[r_bit_number-1];
              //because of clock edge?
			end
		else 
			begin
				 r_MOSI = 1'b1;
			end
	end
			
  always @ (negedge SPI_clk) //latch created but i think ok?
	begin 
      if (r_bit_number <=16 & !CS)
			begin
				r_bit_number <= r_bit_number -1;
			end 
	end 
  assign MOSI = r_MOSI;
endmodule
	
	
module SPI_clk(  
  input clk,
  output SPI_clk  //creates register for later 
);
  reg [5:0] counter =0;
  
  always @ (posedge clk)
    begin
      if (counter <=8)
        counter <= counter +1;
      else 
        counter <=0;
    end
  assign SPI_clk = (counter <=4) ? 1:0;
endmodule 
  

module Data_valid(
  input clk, 
  input SPI_clk,
  input arm,
  input i_write_command,
  output DV
);
  
  localparam waiting = 0;
  localparam data_is_valid = 1;
  localparam data_latched = 2;
  
  
  reg [1:0] state;
  reg [1:0] counter = 0;
  reg [5:0] scounter = 0; 
  reg r_DV;
  
  always @ (posedge clk)
    begin 
      if (counter <=2)
        counter <= counter +1;
      else
        counter <=0;
    end
      
      always @ (negedge SPI_clk)
        begin 
          if (scounter <= 17)
            scounter <= scounter +1;
          else
            scounter <=0;
        end
   
  
  always @ (posedge clk)
    begin
      
      case(state)
        
        waiting: 
          begin 
            if (i_write_command >=15 && SPI_clk && arm) /*last 4 bits are dont care, so even if '0' is written to DAC, the lest 4 bits will always be 1111 = 15. Therefore the data is valid if >=15*/
              begin 
                counter <=0;
              end
            if (counter ==3)
              begin 
                r_DV <= 1;
                state <= data_is_valid;
                scounter <=0;
              end
          end
        
        data_is_valid:
          begin 
            if (scounter ==17)
              begin 
                r_DV <= 0;
                state <= data_latched;
              end
          end
        
        data_latched:
          begin 
            r_DV <=0;
          end
        
        default: 
          begin 
            state <= waiting;
            counter <=0;
            scounter <=0;
          end
      endcase
    end
  
  assign DV = r_DV;
  
endmodule





//Testbench

module tb;
  reg clk,DV;
  reg [15:0] i_write_command,arm;
  wire CS,SPI_clk,MOSI;
  
  always #4 clk = ~clk;
  
  SPI_master uut(clk,DV,i_write_command,CS,SPI_clk,MOSI);
  
  initial
    begin 
      $dumpfile("dump.vcd");
      $dumpvars(0,uut);
      clk=0;
      i_write_command=16'b1111001011001111;
      #100
      DV=1;
      #1312
      DV=0;
      #400
      $finish;
    end
endmodule
