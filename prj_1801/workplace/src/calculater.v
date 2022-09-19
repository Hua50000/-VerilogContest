`timescale 1ps/1ns
module calculater(
	input clk,
	input signed [16:0]key,
	output signed [53:0] dout,
	output signed data_latch);
	
	reg signed [16:0]key_reg;
	wire signed [26:0] data1_reg;
	wire signed [26:0] data2_reg;
	wire signed [53:0] dout_reg;
	wire signed [2:0] arith_reg;
	reg busy_p_reg=0;
	wire busy_a_reg;
	wire en_reg;
	wire data_latch_reg;

	keyboard uut(
		.clk(clk),
		.key(key_reg),
		.busy_p(busy_p_reg),
		.busy_a(busy_a_reg),
		.data1(data1_reg),
		.data2(data2_reg),
		.arith(arith_reg),
		.en(en_reg)
	);
	
	calculat uuu(
		.clk(clk),
		.data1(data1_reg),
		.data2(data2_reg),
		.en(en_reg),
		.arith(arith_reg),
		.data3(dout_reg),
		.data_latch(data_latch_reg),
		.busy(busy_a_reg)
	);
	
	always@(*)
	begin
	end
	assign dout=dout_reg;
	assign data_latch=data_latch_reg;
endmodule