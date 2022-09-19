`include "define.v"
module top3(

	input	wire clk,
	input 	wire rst,
	input 	wire flag_cs,
	input 	wire we_en,

	output	[3:0]state_o,
	output 	rst_cs,
	output 	dacs,
	output 	clk_cs,
	output  cs_o

	);


wire [3:0]rd_st_cnt;
wire rd_st_cnt_en;

wire [3:0]rst_cnt;
wire rst_cnt_en;

wire wait_st2_cnt_en;
wire [3:0]wait_st2_cnt;

wire clk_cs_en;
//wire clk_cs;

//wire cs_o;

wire [3:0]inst;
wire [7:0]instrom;

wire [3:0]waddr;

//ssign cs_o1 = cs_o;

control control0(


	.clk(clk)		,	
	.rst(rst)		,	
	.flag_cs(flag_cs)	,	
	.we_en(we_en)	,		
	.rst_cnt(rst_cnt),
	.wait_st2_cnt(wait_st2_cnt),
	.rd_st_cnt (rd_st_cnt),	
	.waddr(waddr),	
	.rst_cnt_en(rst_cnt_en),
	.wait_st2_cnt_en(wait_st2_cnt_en) ,
	.rd_st_cnt_en(rd_st_cnt_en) ,	
	.clk_cs_en(clk_cs_en) ,	
	.cs_o(cs_o) ,
	.inst(inst) ,
	.state_o(state_o),
	.rst_cs(rst_cs)	


); 

wdata wdata0(
	.clk_cs(clk_cs),
	.rst(rst)	,
	.cs_o(cs_o),
	.instrom(instrom),
	.dacs(dacs),
	.waddr1(waddr)

	);

inst_rom inst_rom0(
	.inst(inst)   ,
	.instrom(instrom)
	
);

clk_div clk_div0(
	.clk(clk),
	.rst(rst),
	.clk_cs_en(clk_cs_en),
	.clk_cs(clk_cs)

	);
counter counter0(
	.clk(clk)	,
	.rst(rst)	,
	.rst_cnt_en(rst_cnt_en),
	.wait_st2_cnt_en(wait_st2_cnt_en),
	.rd_st_cnt_en(rd_st_cnt_en),
	.rst_cnt(rst_cnt),
	.wait_st2_cnt(wait_st2_cnt),
	.rd_st_cnt(rd_st_cnt)
	);

endmodule
