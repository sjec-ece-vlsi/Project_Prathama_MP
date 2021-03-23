module add_sub(
  input clk,mode,cs,
  input [15:0]a,b,
  output reg [15:0]sum,
  output reg ready);
  integer state=0;
  always@(posedge clk)
    begin
      case(state)
        0: begin
          sum=16'bZ;
          ready=1;
          if(cs)
            state=1;
          else
            state=0;
        end
        1: begin
          ready=0;
          
          if(mode)
            state=2;
          else
            state=3;
        end
        2:begin
          sum= a+b;
          state=4;
        end
        3:begin
          sum=a+~b+1;
          state=4;
        end
        4:begin
          ready=1;
          state=0;
        end
      endcase
    end
endmodule
        
