`include "define.v"
module trans(
  input   wire        clk,
  input   wire        rst_n,
  input   wire        BN,
  input   wire        BP,
  output  reg   [1:0] P,
  output  reg   [1:0] N
  );
  


always@(posedge clk or negedge rst_n)begin
  if(rst_n==`RST_EN)begin
    P <= 2'b00;
    N <= 2'b00;
  end
  else begin  
    if(BP == 0)begin
      P <= 2'b00;  
    end
    else begin
        P <= 2'b01;
        if(BN == 0)begin
          N <= 2'b00;
        end
        else begin
          N <= 2'b01;
        end
    end
  end
end
 
endmodule