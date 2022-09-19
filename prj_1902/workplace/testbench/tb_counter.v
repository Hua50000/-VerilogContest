module tb_counter;

reg	clk	;
reg	rst	;

reg	rst_cnt_en;
reg	wait_st2_cnt_en;
reg	rd_st_cnt_en;

wire	[3:0]	rst_cnt;
wire	[3:0]	wait_st2_cnt;
wire	[3:0]	rd_st_cnt;

counter counter1(
	.clk(clk)	,
	.rst(rst)	,
	.rst_cnt_en(rst_cnt_en),
	.wait_st2_cnt_en(wait_st2_cnt_en),
	.rd_st_cnt_en(rd_st_cnt_en),
	.rst_cnt(rst_cnt),
	.wait_st2_cnt(wait_st2_cnt),
	.rd_st_cnt(rd_st_cnt)
	);
always #5 clk = ~clk;

initial begin
	clk =0;
	rst =1;
	wait_st2_cnt_en=0;
	rd_st_cnt_en=0;
	rst_cnt_en=0;
#20
	rst=0;
#20
	wait_st2_cnt_en=1;
	rd_st_cnt_en=1;
	rst_cnt_en=1;

#120
	wait_st2_cnt_en=1;
	rd_st_cnt_en=1;
	rst_cnt_en=1;

#120
	wait_st2_cnt_en=1;
	rd_st_cnt_en=1;
	rst_cnt_en=1;


#120
	$stop;	
end

always@(*)begin
	if (rd_st_cnt==3'd5) begin
		rd_st_cnt_en<=0;
	end
	if (wait_st2_cnt==3'd3) begin
		wait_st2_cnt_en<=0;
	end
	if (rst_cnt==3'd5) begin
	rst_cnt_en=0;
	end
end

endmodule
