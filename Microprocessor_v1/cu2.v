`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2021 15:17:43
// Design Name: 
// Module Name: cu2
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
//fetch-decode
module cu2(clk,reset,ready_dec,ready_fcu,cs_fcu,sel_fcu,cs_dec);
input clk,reset,ready_dec,ready_fcu;
output reg cs_fcu,sel_fcu,cs_dec;
integer state=0;

always@(posedge clk)
begin
case(state)
0:begin
if(reset)
state=0;
else
state=1;
end
1:state=2;
//fetch
2:begin
if(ready_fcu)
state=3;
else
state=2;
end
3:state=4;
//decode
4:begin
if(ready_dec)
state=1;
else
state=4;
end
endcase
end

always@(state)
begin
case(state)
0:begin
cs_fcu=1'bz;
cs_dec=1'bz;
end
//fetch
1:begin
cs_fcu=1;
cs_dec=1'bZ;
sel_fcu=1;
end
//decode
3:begin
cs_dec=1;
cs_fcu=1'bZ;
end
endcase
end
endmodule
