`include "define.v"
module signal_add(
  input   wire        clk,
  input   wire        rst_n,
  input   wire  [1:0] in1,
  input   wire  [1:0] in2,
  output  wire  [1:0] out_wave
  );
  

reg [1:0] a;
reg [1:0] b;

assign out_wave = a + b;

always@(posedge clk or negedge rst_n)begin
  if(rst_n==`RST_EN)begin
	   a <= 2'b00;
	   b <= 2'b00;
	end
  else begin
	   a <= in1;
	   b <= in2;
  end
end

endmodule
  