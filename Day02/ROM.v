/*
 ROM has 4K memory loaction with 16 bit width. 
 Use parameter to define Location, width and address bits required for the ROM.

*/


module ROM_8k(
 clk,cs,request,ready,address,data_out,data_valid,rst
  
);
 localparam state0 = 0; // reset state
 localparam state1 = 1;
 localparam state2 = 2;
 localparam state3 = 3;
 
// parameter for Address width, Data_bus and Memeory Depth or locations
 parameter ADDR_width = 12;
parameter DATA_WIDTH = 16;
parameter MEM_DEPTH = 4096;
  
// Declare inputs and outputs including control signals
 input [ADDR_width-1:0] address;
 input clk,cs,request,rst;
output reg [DATA_WIDTH-1:0]data_out;
output reg data_valid;
 output reg ready; // Check rom is free or busy
 integer i; // This need to replace with readmemh or assign statements
  
// Declare Required internal wires or registers
  reg [DATA_WIDTH-1:0] a[0:MEM_DEPTH-1];
  wire process_ready;
 reg [1:0]current_state,next_state;
 // Logic goes here
 assign process_ready = request & ready;
 always @(posedge clk, rst)
  begin
    // This needs to be replaced with readmemh or assign statements
    for (i=0;i<MEM_DEPTH-1; i= i+1)
      begin
        a[i] = i+1;
      end
    
  end
  
 
 always @(posedge clk, current_state,rst)
  begin
   if(rst)
     begin
      next_state = state0;
      data_valid = 0;
      ready = 1;
    
     end 
   else
    begin
     case(current_state)
      state0: 
       begin
        data_out = 16'bZ;
        ready = 1;
        data_valid = 0;
       if(cs)
        next_state = state1;
        
      else
         begin
        next_state = state0;
        
        
        end
        
        end
       state1: 
        if(process_ready)
         begin
         ready = 0;
          next_state = state2;
         end
      else
       begin
        next_state = state1;
       end
         
       state2:
         begin
        data_out = a[address];
        next_state = state3;
        data_valid = 1;
        end
      state3:
         if(request & data_valid)
            next_state = state3;
        else
            next_state = state0;
        
      
        
       endcase
     current_state = next_state;
    end
  end
  
  
  //end of the logic
  
  
endmodule
