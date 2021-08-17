`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2021 10:06:56
// Design Name: 
// Module Name: rom
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
//read only memory
module rom(input cs,clk,input [15:0] address,output reg ready,output reg [15:0] data);
reg [15:0] ROM[0:(2**12-1)];
integer state=0;

initial
begin
ROM[0]={10'd0,6'b101000};//MOV A,#5
ROM[1]=16'd5;
ROM[2]={10'd0,6'b101001};//MOV B,#0
ROM[3]=16'd0;
ROM[4]={10'd0,6'b111100};//ADD B,A
ROM[5]={8'd8,8'bx};
ROM[6]={10'd0,6'b001000};//SUB A,#1
ROM[7]=16'd1;
ROM[8]={10'd0,6'b111110};//CMZ A
ROM[9]={5'd16,11'bx};
ROM[10]={10'd0,6'b111001};//BNZ 4s
ROM[11]={1'b0,12'd4,3'bx};
end

always@ (posedge clk)
begin
case(state)
0:begin
if(cs)
state=1;
else
state=0;
end
1:state=2;//read
2:state=0;
endcase
end

always@(state)
begin
case(state)
0:begin
ready=1;
data=16'bZ;
end
1:ready=0;
//read
2:begin
data=ROM[address[11:0]];
ready=1;
end
endcase
end
endmodule