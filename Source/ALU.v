module ALU(out,rdy,cout,A,B,op,cs,clk);
    input [3:0]A,B;
    input [2:0]op;
    input cs,clk;
  output [3:0]out;
    output reg rdy,cout;
    //wire cout;
    wire cin,rdy_add,rdy_mul,rdy_log;
    reg cs0,cs1,cs2;
    add_sub alu_add(clk,out,cout,A,B,op[0],op[0],cs0,rdy_add);
    mul alu_mul(clk,out,A,B,cs1,rdy_mul);
    logics  alu_log( out,A,B,cs2,clk,rdy_log,op[1:0]);
    integer state=0;
    always @(posedge clk)
        begin
            case(state)
               0:begin
                if(cs)
                    state=1;
                else  
                    state=0;
               end 
               1:begin
                  case(op)
                   
                    0,1:state=2;
                    2:state=4;
                    4,5,6,7:state=6;
                  endcase  
               end
               2:begin
                    if(rdy_add)
                        state=3;
                    else 
                        state=2;
               end
               4:begin
                    if(rdy_mul)
                        state=5;
                    else
                        state=4;
               end
               6:begin
                    if(rdy_log)
                        state=7;
                    else 
                        state=6;
               end
               3:begin
                    if(rdy_add)
                        state=0;
                    else
                        state=3;
               end
               5:begin
                    if(rdy_mul)
                        state=0;
                    else
                        state=5;
               end
               7:begin
                    if(rdy_log )
                    
                    begin
                    
                     state=0;
                      end
                    else begin
                        state=7; end
               end
            endcase
        end
        always@(state)
            begin
                case(state)
                    0:begin
                        rdy=1;
                        cs0=0;
                        cs1=0;
                        cs2=0;
                    end
                    1:begin
                        rdy=0;
                    end
                    2:begin
                        cs0=1;
                        rdy=1;
                    end
                    4:begin
                        cs1=1;
                        rdy=1;
                    end
                    6:begin
                        cs2=1;
                        rdy=1;
                    end
                endcase
            end
endmodule
