`include "define.v"
module decode_top(
  input   wire      clk,
  input   wire      rst_n,
  input   wire      BN,
  input   wire      BP,
  output  wire      out_wave
  );
  

wire [1:0] P;
wire [1:0] N;
wire [1:0] out_v1;
wire [1:0] out_v2;
wire [1:0] wave_1;
wire [1:0] out_wave_0;
//wire [1:0] wave_2;
wire [1:0] in_wave_1;
//wire in_wave_2;
wire out_wave;

trans t0(
  .clk(clk),
  .rst_n(rst_n),
  .BN(BN),
  .BP(BP),
  .P(P),
  .N(N)
  );
  
check_v c0(
  .clk(clk),
  .rst_n(rst_n),
  .P(P),
  .N(N),
  .out_v1(out_v1),
  .out_v2(out_v2)
  );
  
signal_add s0(
  .clk(clk),
  .rst_n(rst_n),
  .in1(out_v1),
  .in2(out_v2),
  .out_wave(out_wave_0)
  ); 
  
remove_v_b r0(
  .clk(clk),
  .rst_n(rst_n),
  .data_in(out_wave_0),
  .data_out(wave_1)
  );

bit_change b0S(
  .clk(clk),
  .data_in(wave_1),
  .data_out(out_wave)
  );
  

endmodule
