`timescale 1ns/1ns
`include "define.v"
module tb_m_sequence;

reg clk;
reg	rst_n;
wire m_seq;

always #5 clk	= ~clk;
initial	begin
	clk	=0;
	rst_n=0;

#40	rst_n=1;

#3000	$stop;
end

m_sequence #(4'd3,3'b101) M0
(
	.clk(clk),
	.rst_n(rst_n),
	.m_seq(m_seq)
	);
 endmodule
