/*
 Create  a testbench to test 8k ROM with Control signals
 

*/
module rom_tb;

parameter ADDR_width = 4;
parameter DATA_WIDTH = 16;
parameter MEM_DEPTH = (2**ADDR_width);
reg rst;
reg clk,cs,request=1;
reg[ADDR_width-1:0]address=0;
wire ready,data_valid;
wire [DATA_WIDTH-1:0]data_out;

 ROM_8k #(.ADDR_width(ADDR_width), .DATA_WIDTH(DATA_WIDTH), .MEM_DEPTH(MEM_DEPTH)) U0(clk,cs,request,ready,address,data_out,data_valid,rst);
 reg req_flag = 0;
 initial
 begin
  clk =1'b0;
  forever #5 clk = ~clk;
  
 end
 
 initial
 begin
 $display("| clk | Req | ready | Addr | Data               | dv |  St |");
 $monitor("| %3d | %3d | %4d  | %4d | 16%b | %2d   | %2d |",clk,request,ready,address,data_out,data_valid,U0.current_state);
 #1 cs =1;
 #2 rst = 1'b1;
 #2 rst = 1'b0;
 //#2 request = 1;
 //#5 address = 10;
 
 //#50 request = 0;
 
 //#10 request = 1;
 //address = 11;
 
 //repeat(10)
/* begin
  if (req_flag)
  begin
     #5 request = 1'b0;
     #5 request = 1'b1;
    end*/
    
// #60  $finish;

 
 
 end
 
 always@(posedge request)
 begin
 
 address = address + 1;
 end
 
 always @(address)
 begin
 if(address > MEM_DEPTH-1)
   $finish;
 end
 
 always @(data_valid)
  if(data_valid)
    req_flag =1;
  else
    req_flag = 0;
 
 
 always @(data_valid)
 begin
   if(data_valid)
   begin
     request = 1'b0;
     #20;
     end
     request = 1'b1;
     
 end
 endmodule
