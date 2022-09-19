`timescale 1ns/1ns
module tb_top3;
reg clk;
reg rst;
reg flag_cs;
reg we_en;

wire [3:0]	state_o;
wire 	rst_cs;
wire 	dacs;
wire 	clk_cs;
wire 	cs_o;

top3 top3_0(

	.clk(clk),
	.rst(rst),
	.flag_cs(flag_cs),
	.we_en(we_en),

	.state_o(state_o),
	.rst_cs(rst_cs),
	.dacs(dacs),
	.clk_cs(clk_cs),
	.cs_o(cs_o)

	);
always #5 clk = ~clk;

initial begin
	clk=0;
	rst =1;
	we_en=0;
	flag_cs=0;
#100
	rst =0;
#100
	we_en=1;
#200
	flag_cs=1;

#400
	flag_cs=0;
#600
	flag_cs=1;
#100000
	$stop;
end
endmodule