module mem_test;
parameter ADDR_width = 8;
parameter DATA_WIDTH = 8;
parameter MEM_DEPTH = 2**(ADDR_width);
reg [ADDR_width-1:0]addr;
wire [DATA_WIDTH-1:0]data;
integer i = 0;

my_ROM #(.ADDR_width(ADDR_width), .DATA_WIDTH(DATA_WIDTH), .MEM_DEPTH(MEM_DEPTH)) U0(addr, data);

initial
begin
 $monitor("%4d   |   %4d  |  %4d |  ",$time,addr, data);
 
  for(i=128;i< 2**(ADDR_width); i= i+1)
     #5 addr = i;
     
end
endmodule
