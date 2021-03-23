module comparator(out,rdy,a,b,cs,clk);
output reg rdy;
output [2:0] out;
input [15:0] a,b;
input cs,clk;
reg [2:0] out_1; 
integer state=0;
assign out[0]=(cs)?out_1[0]:1'bZ; 
assign out[1]=(cs)?out_1[1]:1'bZ; 
assign out[2]=(cs)?out_1[2]:1'bZ; 
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
                if(a>b)
                state=2;
                else if(a<b)
                state=3;
                else if(a==b)
                state=4;
            end
            2,3,4:state=0;
        endcase
    end
always@(state)
begin
    case(state)
        0:begin
        rdy=1;
        out_1=0;
        end
        1:rdy=0;
        2:begin
        out_1=4;
        rdy=1;
        end
        3:begin
           out_1=2;
           rdy=1;
           end
           4:begin
               out_1=1;
               rdy=1;
                   end
    endcase
end
endmodule
