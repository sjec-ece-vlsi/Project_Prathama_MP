module logics(
  input clk,cs,
  input [1:0]sel,
  input [15:0]a,b,
  output reg [15:0]result,
  output reg ready);
  integer state=0;
  always@(posedge clk)
    begin
      case(state)
        0:begin
          ready=1;
          result=16'bZ;
          if(cs)
            state=1;
          else
            state=0;
        end
        1:begin
          ready=0;
          if(sel==2'b00)
          state=2;
          else if(sel==2'b01)
            state=3;
          else if(sel==2'b10)
            state=4;
          else if(sel==2'b11)
            state=5;
        end
        2:begin
          result=~(a&b);
          state=6;
        end
        3:begin
          result=~(a|b);
          state=6;
        end
        4:begin
          result=(a^b);
          state=6;
        end
        5:begin
          result=~a;
          state=6;
        end
        6:begin
          ready=1;
          state=0;
        end
        
      endcase
    end
endmodule

      
