module my_ROM(Addr,data_out);
parameter ADDR_width = 3;
parameter DATA_WIDTH = 8;
parameter MEM_DEPTH = 15;

input [ADDR_width-1:0] Addr;
output [DATA_WIDTH-1:0]data_out;
reg [DATA_WIDTH-1:0] a[0:MEM_DEPTH-1];
integer i = 0;
initial
 begin
   for (i=0;i<=2**(ADDR_width);i= i +1)
     a[i] = i+1;
 end

//always @(Addr)
//$display("The addr = ",Addr);


assign data_out = a[Addr];

endmodule
