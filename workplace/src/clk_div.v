`include "define.v"
module clk_div(
	input 	wire 	clk,
	input	wire	rst,
	input	wire 	clk_cs_en,

	output	reg		clk_cs
	);
reg test;

reg	[2:0]	clk_cnt;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		clk_cs	<= 	1'b0;
		clk_cnt	<=	4'd0		;	
	end
	else if (clk_cs_en==`CLK_CS_ENABLE) begin
		if (clk_cnt==4'd1) begin
			clk_cs 	<=	~clk_cs 	;		
			clk_cnt	<=	4'd0		;	
		end
		else begin
			clk_cs 	<=	clk_cs 	;
			clk_cnt	<=	clk_cnt	+ 	4'd1;	
		end
	end
	else begin
			clk_cs 	<=	clk_cs 	;
			clk_cnt	<=	4'd0		;	
	end

end

endmodule
