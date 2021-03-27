`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2021 10:50:54
// Design Name: 
// Module Name: mul
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
//mul
module mul(clk,result,A,B,cs,rdy);
output reg [15:0]  result;
output reg rdy;
input [15:0] A,B;
input cs,clk;
integer state=0;
initial state=0;

always@(posedge(clk))
begin
case(state)
0:begin
if(cs)
state=1;
else
state=0;
end
1:state=2;          
2:state=0;
endcase
end

always@(state)
begin
case(state)
0:begin
rdy=1;
result=16'bZ;
end
1:rdy=0;
2:begin
result=A[7:0]*B[7:0];
rdy=1;
end
endcase
end
endmodule
