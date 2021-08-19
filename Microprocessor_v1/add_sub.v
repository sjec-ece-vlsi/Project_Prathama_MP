`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2021 10:50:28
// Design Name: 
// Module Name: add_sub
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
//add_sub
module add_sub(clk,SUM,COUT,A,B,CIN,SUB,cs,rdy);   
input [15:0]A,B;
input SUB,cs,CIN,clk;
output reg [15:0]SUM;
output reg COUT,rdy;
integer state;
initial state=0;

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
if(SUB) //sub
state=3;
else //add
state=2;
end
//add
2:state=4;
//sub
3:state=5;
4,5:state=0;
endcase        
end

always@(state)
begin 
case(state)  
0:begin
rdy=1;
SUM=16'bZ; 
COUT=1'bZ;
end
1:begin
rdy=0;
end  
//add
2:begin
{COUT,SUM}=A+B+CIN;
end 
//sub
3:begin
{COUT,SUM}=A+~B+1;
end 
4,5:rdy=1;
endcase              
end
endmodule
