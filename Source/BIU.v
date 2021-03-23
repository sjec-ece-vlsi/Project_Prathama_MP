module BIU(data,ready,cs, clk, sel,ir);
inout [15:0] data;
output reg ready;
input cs,clk;
input [1:0] sel;
input [31:0] ir;
reg [15:0] mbr;
integer state=0;
reg [15:0]address;
reg cs_gpr,read;
wire ready_gpr;
gpr u0(clk, data,read,address,cs_gpr,ready_gpr);

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
endcase
end

always@(state,data)
begin
case(state)
0:begin
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
//cs_gpr=0;
end

endcase
end
assign data=(cs_gpr&~read)?mbr:16'bZ;
endmodule
