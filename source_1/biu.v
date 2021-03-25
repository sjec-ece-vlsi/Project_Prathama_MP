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


module biu(data,ready1,cs,clk, sel,ir,sel_eu,op_sel);
output [15:0] data;
output  ready1;
input cs,clk;
input [1:0] sel,sel_eu,op_sel;
input [31:0] ir;
reg ready;
reg [15:0] mbr;
integer state=0;
reg [15:0]address;
reg cs_gpr,read,cs_ram;
wire ready_gpr,ready_ram;
wire  [15:0]data1,data2;

gpr u0(clk, data,read,address,cs_gpr,ready_gpr);
ram r0(clk,data,read,address,cs_ram,ready_ram);

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
if(sel==2'b00)
state=2;
else if(sel==2'b01)
state=9;
else if(sel==2'b10)
state=18;
end
2: begin
if(ir[19])
state=7;
else
state=3;
end
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
if(ir[18])
state=14;
else
state=10;
end
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
end
1:ready=0;
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
7:begin
cs_gpr=1;
end
8:begin
address={13'd0,ir[18:16]};
mbr=ir[15:0];
read=0;
ready=1;
end
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
18:cs_gpr=1;
19:begin
case(sel_eu)
    2'b00:begin
        case(op_sel)
        2'b00:begin
            address={13'b0,ir[18:16]};
            read=1;
        end
2'b 10:begin
address={13'd0,ir[18:16]};
read=0;
end
endcase
end


2'b01:begin
case(op_sel)
2'b00:begin
address={13'd0,ir[13:11]};
read=1;
end
2'b01:begin
address={13'd0,ir[10:8]};
read=1;
end
2'b10:begin
address={13'd0,ir[13:11]};
read=0;
end
endcase
end


2'b10:begin
case(op_sel)
2'b00:begin
address={13'd0,ir[14:12]};
read=1;
end
2'b01:begin
address={13'd0,ir[11:9]};
read=1;
end
endcase
end
endcase

ready=1;
end
//50,51,52,53:ready=1;
endcase
end
//always@(ready_gpr,ready_ram,ready)
//begin
assign ready1=(ready_gpr&ready_ram)&ready;
//end
assign data=((cs_gpr|cs_ram)&~read)?mbr:16'bZ;
//assign ready=ready_gpr&ready_ram&~cs_gpr&~cs_ram;
endmodule
