`include "define.v"
module HDB3_creat(
  input   wire  clk,
  input   wire  rst_n,
  output  wire  out
  );
  

wire clk_div;
wire m_seq;
wire BN;
wire BP;


clk_divider u1(
    .clk(clk),
    .rst_n(rst_n),
    .clk_div(clk_div)
    );  
  
m_sequence u2 (
  .clk(clk_div),
  .rst_n(rst_n),
  .m_seq(m_seq)
);

encode_top u3( 
  .clk(clk_div),//(clk_div),
  .rst_n(rst_n),
  .data_m(m_seq),
  .BP(BP),
  .BN(BN)
  );

decode_top u4(
  .clk(clk_div),
  .rst_n(rst_n),
  .BN(BN),
  .BP(BP),
  .out_wave(out)
  );
  
endmodule