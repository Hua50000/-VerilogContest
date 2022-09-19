`include "define.v"
module encode_top(
  input       wire    clk,
  input       wire    rst_n,
  input       wire    data_m,
  output      wire    BP,
  output      wire    BN
  );


wire [1:0] data_out_v;
wire [1:0] data_out_b;

creat_v u1(
  .clk(clk),
  .rst_n(rst_n),
  .data_in(data_m),
  .data_out_v(data_out_v)
  );
  
creat_b u2(
  .clk(clk),
  .rst_n(rst_n),
  .data_in_v(data_out_v),
  .data_out_b(data_out_b)
  );
  
change_pole u3(
 .clk(clk),
 .rst_n(rst_n),
 .data_in_b(data_out_b),
 .BP(BP),
 .BN(BN)
  );
 
endmodule