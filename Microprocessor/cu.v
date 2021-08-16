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

//control unit
module cu(clk,reset);
  reg [1:0] flag;
input clk,reset;
wire cs_dec,cs_fcu;
wire ready_dec,ready_fcu;
wire ready_bus,ready_eu,cs_eu,cs_biu,sel_fcu;
wire [1:0]sel_eu,sel_biu,op_sel;
wire [15:0] bus;
wire reset;
wire [15:0]fetch_address;
wire [31:0] ir;
reg cs_bu;
//instantiation
  decoder dec0(flag,clk,cs_dec,ready_bus,ready_eu,ir,ready_dec,cs_fcu,cs_biu,cs_eu,sel_fcu,sel_eu,sel_biu);
biu biu1(bus,ready_bus,cs_biu,clk, sel_biu,ir,sel_eu,op_sel,fetch_address);
eu eu2(ir,sel_eu,ready_bus,bus,cs_eu,clk,ready_eu,op_sel,cs_biu,sel_biu);
fcu fcu3(clk,reset,cs_fcu,sel_fcu,ready_fcu,fetch_address,ir,bus,sel_biu,cs_biu,ready_bus);
cu2 cu4(clk,reset,ready_dec,ready_fcu,cs_fcu,sel_fcu,cs_dec);

always@(cs_biu)
begin
cs_bu=cs_biu;
end
endmodule
