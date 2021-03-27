module ROM_8k(
  input cs,clk,
  input [15:0] address,
  output reg ready,
  output reg [15:0] data);
  reg [15:0] ROM[0:(2**12-1)];
  always@ (posedge clk)
    begin
      case(state)
        0:begin
          if(cs)
          state=1;
        else
          state=0;
        end
        1: state=2;
        2: state=0;
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
        2:begin
          data=ROM[address[11:0]];
          ready=1;
        end
      endcase
    end
  
        
  
