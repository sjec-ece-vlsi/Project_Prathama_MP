`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2021 10:47:49
// Design Name: 
// Module Name: biu
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

//bus interface unit
module biu(data,ready1,cs,clk, sel,ir,sel_eu,op_sel,fetch_address);
output [15:0] data;
output  ready1;
input cs,clk;
input [15:0] fetch_address;
input [1:0] sel,sel_eu,op_sel;
input [31:0] ir;
reg ready,cs_gpr,read,cs_ram,cs_rom;
reg [15:0] mbr,address;
wire ready_gpr,ready_ram,ready_rom;
integer state=0;
//instantiation
gpr u0(clk, data,read,address,cs_gpr,ready_gpr);
ram r0(clk,data,read,address,cs_ram,ready_ram);
rom r1(cs_rom,clk,address,ready_rom,data);

always@(posedge clk)
begin
case(state)
0: begin
if(cs)
state=1;
else
state=0;
end
1:begin
if(sel==2'b00)//mov
state=2;
else if(sel==2'b01)//load,store
state=9;
else if(sel==2'b10)//execution
state=18;
else//fetch
state=20;
end

2: begin
if(ir[19])//mov immediate
state=7;
else//mov reg
state=3;
end
//mov reg
3: begin
if(ready_gpr)
state=4;
else
state=3;
end
4: begin
if(ready_gpr)
state=5;
else
state=4;
end
5:begin
if(ready_gpr)
state=6;
else
state=5;
end
6:begin
if(ready_gpr)
state=0;
else
state=6;
end
//mov immediate
7:begin
if(ready_gpr)
state=8;
else
state=7;
end
8:begin
if(ready_gpr)
state=0;
else
state=8;
end

9:begin
if(ir[18])//store
state=14;
else//load
state=10;
end
//load
10:begin
if(ready_ram)
state=11;
else
state=10;
end
11:begin
if(ready_ram)
state=12;
else
state=11;
end
12:begin
if(ready_gpr)
state=13;
else
state=12;
end
13:begin
if(ready_gpr)
state=0;
else
state=13;
end
//store
14:begin
if(ready_gpr)
state=15;
else
state=14;
end
15:begin
if(ready_gpr)
state=16;
else
state=15;
end
16:begin
if(ready_ram)
state=17;
else
state=16;
end
17:begin
if(ready_ram)
state=0;
else
state=17;
end
//execution
18:begin
if(ready_gpr)
state=19;
else
state=18;
end
19:begin
if(ready_gpr)
state=0;
else
state=19;
end
//fetch
20:begin
if(ready_rom)
state=21;
else
state=20;
end
21:begin
if(ready_rom)
state=0;
else
state=21;
end
endcase
end

always@(state,data)
begin
case(state)
0:begin
cs_ram=0;
cs_gpr=0;
ready=1;
mbr=16'bZ;
address=16'bZ;
end
1:ready=0;
//mov reg
3:cs_gpr=1;
4:begin
address={13'd0,ir[15:13]};
read=1;
mbr=data;
end
6:begin
address={13'd0,ir[18:16]};
read=0;
ready=1;
end
//mov immediate
7:begin
cs_gpr=1;
end
8:begin
address={13'd0,ir[18:16]};
mbr=ir[15:0];
read=0;
ready=1;
end
//load
10:cs_ram=1;
11:begin
address={2'd0,ir[14:1]};
mbr=data;
read=1;
end
12:begin
cs_ram=0;
cs_gpr=1;
end
13:begin
address={13'd0,ir[17:15]};
read=0;
ready=1;
end
//store
14:cs_gpr=1;
15:begin
address={13'd0,ir[17:15]};
read=1;
mbr=data;
end
16:begin
cs_gpr=0;
cs_ram=1;
end
17:begin
address={2'd0,ir[14:1]};
read=0;
ready=1;
end  
//execution
18:cs_gpr=1;
19:begin
case(sel_eu)
2'b00:begin//arith_i
case(op_sel)
2'b00:begin//first operand
address={13'b0,ir[18:16]};
read=1;
end
2'b10:begin//result
address={13'd0,ir[18:16]};
read=0;
end
endcase
end

2'b01:begin//arith
case(op_sel)
2'b00:begin//first operand
address={13'd0,ir[13:11]};
read=1;
end
2'b01:begin//second operand
address={13'd0,ir[10:8]};
read=1;
end
2'b10:begin//result
address={13'd0,ir[13:11]};
read=0;
end
endcase
end

2'b10:begin//compare
case(op_sel)
2'b00:begin//first operand
address={13'd0,ir[14:12]};
read=1;
end
2'b01:begin//second operand
address={13'd0,ir[11:9]};
read=1;
end
endcase
end
endcase
ready=1;
end
//fetch
20:cs_rom=1;
21:begin
address=fetch_address;
read=1;
ready=1;
cs_rom=1'bZ;
end
endcase
end

assign ready1=(ready_gpr&ready_ram&ready_rom)&ready;
assign data=((cs_gpr|cs_ram)&~read)?mbr:16'bZ;
endmodule
