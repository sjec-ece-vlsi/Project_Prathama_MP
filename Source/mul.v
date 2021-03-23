module mul(
  input clk,cs,
  input [15:0]a,b,
  output reg [15:0]product,
  output reg ready);
  
  integer state=0;
  always@(posedge clk)
    begin
      case(state)
        0:begin
          ready=1;
          product=16'bZ;
          if(cs)
            state=1;
          else
            state=0;
        end
        1:begin
          ready=0;
          state=2;
        end
        2:begin
          product=a[7:0]*b[7:0];
          state=3;
        end
        3:begin
          ready=1;
          state=0;
        end
      endcase
    end
endmodule
