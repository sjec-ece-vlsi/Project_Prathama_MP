module ALU(
  input clk,cs,
  input [15:0]a,b,
  output [15:0] bus,
  output reg ready);
  //reg [15:0] temp;
  reg cs_add,mode;
  wire ready_add;
  wire [15:0] sum;
  integer state=0;
  add_sub U0(clk,mode,cs_add,a,b,bus,ready_add);
  
  always@(posedge clk)
    begin
      case(state)
        0:begin
          //bus=16'bZ;
          ready=1;
          cs_add=0;
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
          cs_add=1;
          mode=0;
          if(ready_add)
            state=3;
          else
            state=2;
        end
        3:begin
          if(ready_add)
            state=4;
          else
            state=0;
        end
        /*4:begin
          ready=1;
          state=0;
        end*/
      endcase
    end
endmodule
