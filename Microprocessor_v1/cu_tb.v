`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2021 11:25:26
// Design Name: 
// Module Name: cu_tb
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
//test_bench
module cu_tb;
reg clk,reset;

cu c0(clk,reset);

initial
begin
clk=1'b0;
forever #5 clk=~clk;
end

initial
begin
reset=1;
#10;
reset=0;
#6000 $finish;
end
endmodule
