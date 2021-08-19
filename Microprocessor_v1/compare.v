`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2021 09:34:02
// Design Name: 
// Module Name: compare
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
//comparator
module compare(cs,A,B,clk,ready,c,z);
input clk,cs;
input [15:0]A,B;
output reg ready,c,z;
integer state;

initial 
begin
state=0;
end

always@(posedge clk)
begin
case(state)
0:begin
if(cs)
state=1;
else
state=0;
end
1:begin
if(A>B)
state=2;
else if(A==B)
state=3;
else
state=4;
end
2,3,4:state=0;
endcase
end

always@(state)
begin
case(state)
0:ready=1;
1:ready=0;
2:begin
c=1;
z=0;
ready=1;
end
3:begin
c=0;
z=1;
ready=1;
end
4:begin
c=0;
z=0;
ready=1;
end
endcase
end
endmodule
