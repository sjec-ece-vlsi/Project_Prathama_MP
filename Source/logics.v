module logics( out_d,A,B,cs,clk,rdy,op_sub);
  output reg [15:0] out_d;
  input [15:0] A,B;
     input cs,clk;
     input [1:0]op_sub;
     output reg rdy;
     integer state;
     initial 
     begin
     state=0;
    
     end
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
            case(op_sub)
                0:state=2;
                1:state=3;
                2:state=4;
                3:state=5;
            endcase
           end
         2:state=0;
         3:state=0;
         4:state=0;
         5:state=0;
     endcase
     end
     always @(state)
        begin
            case(state)
                0:begin 
                    rdy=1;
                    out_d=16'bz;
                end
                1:begin rdy=0;   end
                2:begin
                    out_d=~(A &B);
                    rdy=1;
                end
                3:begin
                    out_d=~(A |B);
                    rdy=1;
                end
                4:begin
                    out_d=A^B;
                    rdy=1;
                end
                5:begin
                    out_d=~A;
                    rdy=1;
                end
            endcase   
         end
endmodule
