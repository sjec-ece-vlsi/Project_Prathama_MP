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
ROM[0]={10'd0,6'b101000};
ROM[1]=16'd30;
ROM[2]={10'd0,6'b101001};
ROM[3]=16'd20;
ROM[4]={10'd0,6'b110100};
ROM[5]={1'b0,14'd0,1'bx};
ROM[6]={10'd0,6'b110100};
ROM[7]={1'b1,14'd1,1'bx};
ROM[8]={10'd0,6'b111100};
ROM[9]={8'b00000001,8'dx};
ROM[10]={10'd0,6'b110100};
ROM[11]={1'b0,14'd2,1'bx};
ROM[12]={10'd0,6'b110000};
ROM[13]={1'b0,14'd0,1'bx};
ROM[14]={10'd0,6'd0};
ROM[15]=16'd30;
ROM[16]={10'd0,6'b110100};
ROM[17]={1'b0,14'd3,1'bx};
ROM[18]={10'd0,6'b110000};
ROM[19]={1'b1,14'd1,1'bx};
ROM[20]={10'd0,6'b000001};
ROM[21]=16'd30;
ROM[22]={10'd0,6'b110100};
ROM[23]={1'b1,14'd4,1'bx};
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
