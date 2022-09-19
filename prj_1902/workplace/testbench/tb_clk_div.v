`timescale 1ns/1ns
module tb_clk_div ;

	reg 	clk;
	reg		rst;
	reg		clk_cs_en;

	wire	clk_cs;

clk_div clk_div1(
	.clk(clk),
	.rst(rst),
	.clk_cs_en(clk_cs_en),
	.clk_cs(clk_cs)
	);

always #5 clk = ~clk;

initial begin
	clk =0;
	rst =1;
	clk_cs_en=0;
#20
	rst=0;
#20
	clk_cs_en=1;

#1000
	clk_cs_en=0;
#100
	$stop;	
end

endmodule