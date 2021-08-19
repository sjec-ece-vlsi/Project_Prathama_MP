`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2021 10:49:26
// Design Name: 
// Module Name: gpr
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
//general purpose register
module gpr(clk, data,read,address,cs,rdy);
parameter data_width=16;
parameter address_width=16;
parameter memory_depth=8;
inout  [data_width-1:0] data;
input[address_width-1:0] address;
input cs,read,clk ;
output reg rdy ;
reg [data_width-1:0] data_1;
reg [data_width-1:0] GPR[memory_depth-1:0];
integer state=0;

always @ (posedge clk)
begin
case(state)
0: begin
if(cs)
state=1;
else
state=0;
end
1:begin
if(~read)//write
state=2;
else//read
state=3;
end
2,3: state=0;
endcase
end

always@(state)
case(state)
0:begin
rdy=1;
data_1=16'bZ;
end
1:begin
rdy=0;
end
//write
2:begin
GPR[address[2:0]]=data;
rdy=1;
end
//read
3:begin
data_1=GPR[address[2:0]];
rdy=1;
end
endcase

assign data=(cs&read)?data_1:16'bZ;
endmodule
