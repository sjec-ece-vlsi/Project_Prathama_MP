`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2021 10:48:12
// Design Name: 
// Module Name: eu
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


module eu(ir,sel_eu,ready_biu,bus,cs,clk,ready1,op_sel,cs_biu,sel);
input [31:0] ir;
input [1:0] sel_eu;
input ready_biu,clk,cs;
inout [15:0] bus;
output ready1;
output reg cs_biu;
output reg [1:0] op_sel,sel;
reg temp,ready,cs_alu;
reg [15:0] tempA,temp_result,A,B;
reg [2:0] opcode;
wire ready_alu,cout;
wire [15:0] out;
integer state=0;

alu b0(out,ready_alu,cout,A,B,opcode,cs_alu,clk);

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
if(sel_eu==2'b00)
state=2;
else if(sel_eu==2'b01)
state=8;
end
2:begin
if(ready_biu)
state=3;
else
state=2;
end
3:begin
if(ready_biu)
state=4;
else
state=3;
end
4:begin
if(ready_alu)
state=5;
else
state=4;
end
5:begin
if(ready_alu)
state=6;
else
state=5;
end
6:begin
if(ready_biu)
state=7;
else
state=6;
end
7:begin
if(ready_biu)
state=0;
else
state=7;
end
8:begin
state=9;
end
9:begin
if(ready_biu)
state=10;
else
state=9;
end
10:begin
if(ready_biu)
state=11;
else
state=10;
end
11:begin
if(ready_biu)
state=12;
else
state=11;
end
12:begin
if(ready_alu)
state=13;
else
state=12;
end
13:begin
if(ready_alu)
state=14;
else
state=13;
end
14:begin
if(ready_biu)
state=15;
else
state=14;
end
15:begin
if(ready_biu)
state=0;
else
state=15;
end
endcase
end

always@(state,bus)
begin
case(state)
0:begin
ready=1;
temp_result=16'bz;
cs_biu=1'bZ;
sel=2'bZ;
cs_alu=0;
temp=0;
end
1:ready=0;
2:begin
cs_biu=1;
sel=2'b10;
end
3:begin
op_sel=2'b00;
tempA=bus;
end
4:begin
cs_alu=1;
cs_biu=0;
end
5:begin
B=ir[15:0];
A=tempA;
opcode={1'b0,ir[20:19]};
temp_result=out;
end
6:begin
cs_alu=0;
cs_biu=1;
end
7:begin
op_sel=2'b10;
ready=1;
end
8:begin
cs_biu=1;
sel=2'b10;
end
9:begin
op_sel=2'b00;
tempA=bus;
end
11:begin
op_sel=2'b01;
B=bus;
end
12:begin
cs_alu=1;
cs_biu=0;
end
13:begin
A=tempA;
opcode=ir[16:14];
end
14:begin
cs_alu=0;
cs_biu=1;
temp_result=out;
end
15:begin
temp=1;
op_sel=2'b10;
ready=1;
end
endcase
end

assign ready1=ready_biu&ready_alu&ready;
assign bus=temp?temp_result:16'bz;
endmodule

