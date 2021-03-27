`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2021 10:04:42
// Design Name: 
// Module Name: fcu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fcu(clk,reset,cs_fcu,sel_fcu,ready1,fetch_address,ir,bus,sel_biu,cs_biu,ready_biu);
input cs_fcu,clk,sel_fcu,reset;
input [15:0] bus;
output ready1;
output reg cs_biu;
output reg [1:0] sel_biu;
output [31:0] ir;
output  reg [15:0] fetch_address;
reg [15:0] pc;
reg [31:0] ir;
reg ready;
input ready_biu;
integer state=0;
 always@(posedge clk)
 begin
 case(state)
 0:begin
 if(reset)
 state=0;
 else
 state=1;
 end
 1:begin
 if(cs_fcu)
 state=2;
 else
 state=1;
 end
 2:begin
if(sel_fcu==1'b1)
 state=3;
 end
 3:begin
 if(ready_biu)
 begin
 if(pc[0])
  state=5;
  else
  state=4;
  end
 else
 state=3;
 end
 
4:begin
if(ready_biu)
state=3;
else
state=4;
end
5:begin
if(ready_biu)
state=1;
else
state=5;
end
endcase
end

always@(state,bus)
begin
case(state)
0:begin 
pc=0;
ready=1;
end
1:begin
ready=1;
cs_biu=1'bZ;
sel_biu=2'dZ;
//fetch_address=16'bz;
end
2:ready=0;
3:begin
cs_biu=1;
sel_biu=2'b11;
fetch_address=pc;
end
4:begin
ir[31:16]=bus;
//pc=pc+1;
//fetch_address=pc;
end
5:begin
ir[15:0]=bus;
//pc=pc+1;
ready=1;
end

endcase
end
always@(state)
begin
case(state)
4,5:pc=pc+1;
endcase
end
assign ready1= ready_biu&ready;
//assign fetch_address=cs_biu?pc:16'bZ;
endmodule
