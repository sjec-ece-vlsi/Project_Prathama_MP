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
//execution unit
module eu(ir,sel_eu,ready_biu,bus,cs,clk,ready1,op_sel,cs_biu,sel,cout,c,z);
input [31:0] ir;
input [1:0] sel_eu;
input ready_biu,clk,cs;
inout [15:0] bus;
output ready1,cout;
output reg cs_biu;
output reg [1:0] op_sel,sel;
reg temp,ready,cs_alu,cs_cmp;
reg [15:0] tempA,temp_result,A,B;
reg [2:0] opcode;
output c,z;
wire ready_alu,ready_cmp;
wire [15:0] out;
integer state=0;

//instantiation
alu b0(out,ready_alu,cout,A,B,opcode,cs_alu,clk);
compare c0(cs_cmp,A,B,clk,ready_cmp,c,z);

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
if(sel_eu==2'b00)//arith_i
state=2;
else if(sel_eu==2'b01)//arith
state=8;
else //comp
state=16;
end
//arith_i
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
//arith
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
//compare
16:begin
if(ir[15])
state=23;
else
state=17;
end
17:begin
if(ready_biu)
state=18;
else
state=17;
end
18:begin
if(ready_biu)
state=19;
else
state=18;
end
19:begin
if(ready_biu)
state=20;
else
state=19;
end
20:begin
if(ready_biu)
state=21;
else
state=20;
end
21:begin
if(ready_cmp)
state=22;
else
state=21;
end
22:begin
if(ready_cmp)
state=0;
else
state=22;
end
23:begin
if(ready_biu)
state=24;
else
state=23;
end
24:begin
if(ready_biu)
state=25;
else
state=24;
end
25:begin
if(ready_cmp)
state=26;
else
state=25;
end
26:begin
if(ready_cmp)
state=0;
else
state=26;
end
endcase
end

always@(state,bus,out)
begin
case(state)
0:begin
ready=1;
temp_result=16'bz;
cs_biu=1'bZ;
sel=2'bZ;
cs_alu=0;
cs_cmp=0;
temp=0;
//temp2=0;
end
1:ready=0;
//arith_i
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
temp_result=out;
end
7:begin
op_sel=2'b10;
ready=1;
temp=1;
end
//arith
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
//compare
17:begin
cs_biu=1;
sel=2'b10;
end
18:begin
op_sel=2'b0;
tempA=bus;
end
20:begin
op_sel=2'b01;
B=bus;
end
21:begin
cs_cmp=1;
cs_biu=0;
end
22:begin
A=tempA;
ready=1;
end
23:begin
cs_biu=1;
sel=2'b10;
end
24:begin
op_sel=2'b00;
tempA=bus;
end
25:begin
cs_cmp=1;
cs_biu=0;
end
26:begin
B=16'd0;
A=tempA;
ready=1;
end
endcase
end

assign ready1=ready_biu&ready_alu&ready;
assign bus=(temp)?temp_result:16'bz;
endmodule