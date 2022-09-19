`include "define.v"
module counter(

	input	wire	clk	,
	input	wire	rst	,

	input	wire	rst_cnt_en,
	input 	wire	wait_st2_cnt_en,
	input	wire	rd_st_cnt_en,

	output 	reg		[3:0]	rst_cnt,
	output 	reg		[3:0]	wait_st2_cnt,
	output 	reg 	[3:0]	rd_st_cnt



	);

always @(posedge clk or posedge rst) begin
	if (rst) begin
		rst_cnt 	<=	4'b0	;
		
	end
	else if (rst_cnt_en==`RST_CNT_ENABLE) begin
		rst_cnt 	<=	rst_cnt +	4'b1	;
	end
	else begin
		rst_cnt 	<=	4'b0	;
	end
end

always @(posedge clk or posedge rst) begin
	if (rst) begin
		wait_st2_cnt 	<=	4'b0	;
		
	end
	else if (wait_st2_cnt_en==`CLK_ST2_CNT_EN) begin
		wait_st2_cnt 	<=	wait_st2_cnt +	4'b1	;
	end
	else begin
		wait_st2_cnt 	<=	4'b0	;
	end
end

always @(posedge clk or posedge rst) begin
	if (rst) begin
		rd_st_cnt	<=	4'b0	;
		
	end
	else if (rd_st_cnt_en==`RD_ST_CNT_EN) begin
		rd_st_cnt 	<=	rd_st_cnt +	4'b1	;
	end
	else begin
		rd_st_cnt 	<=	4'b0	;
	end
end

endmodule
