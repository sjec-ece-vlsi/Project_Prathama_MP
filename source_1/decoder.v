`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2021 10:47:20
// Design Name: 
// Module Name: decoder
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


module decoder(clk,cs,ready_bus,ready_eu,ir,ready1,cs_fcu,cs_biu,cs_eu,sel_fcu,sel_eu,sel_biu);
input [31:0] ir;
input clk,cs,ready_bus,ready_eu;
output ready1;
output  reg cs_fcu,cs_biu,cs_eu;
integer state=0;
reg ready;
wire arith_i,arith,comp,l_st,branch,mov;
output reg sel_fcu;
output reg [1:0] sel_biu,sel_eu;
wire ready_bus,ready_eu,ready_fcu;

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
if(arith_i|arith|comp)
state=2;
else if(mov|l_st)
state=3;
else
state=4;
end
2:begin
if(ready_eu)
state=5;
else
state=2;
end
3:begin
if(ready_bus)
state=6;
else
state=3;
end
4: begin
if(ready_fcu)
state=7;
else
state=4;
end
5: begin
if(ready_eu)
state=0;
else
state=5;
end
6: begin
if(ready_bus)
state=0;
else
state=6;
end
7:begin
if(ready_fcu)
state=0;
else
state=7;
end
endcase
end

always@(state)
begin
case(state)
0:begin
ready=1;
cs_fcu=1'bZ;
cs_biu=1'bZ;
cs_eu=1'bZ;
end
1:ready=0;
2:begin
cs_eu=1;
cs_fcu=1'bZ;
cs_biu=1'bZ;
sel_eu[1]=~arith_i&~arith&comp;
sel_eu[0]=~arith_i&arith&~comp;
sel_biu=2'bz;
end
3:begin
cs_biu=1;
cs_fcu=1'bZ;
cs_eu=1'bZ;
sel_biu[0]=~mov&l_st;
sel_biu[1]=0;
end
4:begin
cs_fcu=1;
cs_eu=1'bZ;
cs_biu=1'bZ;
sel_fcu=0;
end
5,6,7:ready=1;
endcase
end


assign ready1=ready_bus&ready_eu&ready;


assign arith_i=~ir[21];
assign mov=ir[21]&~ir[20];
assign l_st=ir[21]&ir[20]&~ir[19];
assign branch=ir[21]&ir[20]&ir[19]&~ir[18];
assign arith=ir[21]&ir[20]&ir[19]&ir[18]&~ir[17];
assign comp=ir[21]&ir[20]&ir[19]&ir[18]&ir[17]&~ir[16];
endmodule


