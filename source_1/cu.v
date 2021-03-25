`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2021 10:46:22
// Design Name: 
// Module Name: cu
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
module cu(ir,clk,cs,ready);
input [31:0] ir;
input clk,cs;
output ready;
wire ready_bus,ready_eu,cs_eu,cs_fcu,cs_biu,sel_fcu;
wire [1:0]sel_eu,sel_biu,op_sel;
wire [15:0] bus;
reg cs_bu;
decoder dec1(clk,cs,ready_bus,ready_eu,ir,ready,cs_fcu,cs_biu,cs_eu,sel_fcu,sel_eu,sel_biu);
biu biu1(bus,ready_bus,cs_biu, clk, sel_biu,ir,sel_eu,op_sel);
eu eu1(ir,sel_eu,ready_bus,bus,cs_eu,clk,ready_eu,op_sel,cs_biu,sel_biu);

always@(cs_biu)
begin
cs_bu=cs_biu;
end
endmodule