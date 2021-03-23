module add_sub(clk,SUM,COUT,A,B,CIN,SUB,cs,rdy);   
 input [3:0]A,B;
 input SUB,cs,CIN,clk;
 output reg [3:0]SUM;
 output reg COUT,rdy;
 integer state;
initial
state=0;
always@(posedge clk)
    begin
        case(state)
            0:begin
                if(cs)  state=1;
                else    state=0;
            end
            1:begin
                if(SUB) state=3;
                else state=2;
            end
            2:state=0;
            3:state=0;
        endcase        
    end
 always@(state)
        begin 
        case(state)  
            0:begin
             rdy=1;
             SUM=16'bZ; 
             COUT=1'bZ;
             end
            1:begin
             rdy=0;
             end  
            2:begin
             {COUT,SUM}=A+B+CIN;
             rdy=1;
             end 
            3:begin
              {COUT,SUM}=A+~B+1;
              rdy=1;           
              end 
         endcase              
        end
endmodule
