`include "define.v"
module control(

	//INPUT FROM GLOUBLE
	input	wire	clk		,	
	input	wire	rst		,	// 1'b1 for available
	input	wire	flag_cs	,	// 1'b1	for configuration is successful
	input 	wire	we_en	,	

	//INPUT FROM COUNTER
	input 	wire	[3:0]	rst_cnt,
	input 	wire	[3:0]	wait_st2_cnt,
	input 	wire 	[3:0]	rd_st_cnt,
	//INPUT FROM WDATA
	input 	wire 	[3:0]	waddr,
	//OUTPUT FOR COUNTER
	output 			reg rst_cnt_en,
	output 			reg wait_st2_cnt_en,
	output			reg rd_st_cnt_en,
	//OUTPUT FOR CLK_DIV
	output 			reg clk_cs_en,
	//OUTPUT FOR WDATA
	output 					reg cs_o,
	//OUTPUT FOR INST_ROM
	output 	reg 	[3:0] inst,
	//OUTPUT FOR GLOUBLE
	output	reg		[3:0]state_o	,
	output	reg		rst_cs	
	//output	reg		clk_cs	

); 

//STATE REG 
reg	[3:0]	current_state 	;
reg	[3:0]	next_state		;



always @(posedge clk or posedge rst) begin
	if (rst) begin
		current_state	<=	`rst_s0	;
	end
	else begin
		current_state	<=	next_state;
	end
end


always @(*) begin
	case(current_state)
		`rst_s0:begin
			if (rst_cnt==3'd6) begin
				next_state	<=	`clk_conf_st1	;
			end
			else begin
				next_state	<=	current_state	;
			end
		end
		`clk_conf_st1:begin
			next_state	<=	`wait_st2	;
		end
		`wait_st2:begin
			if (wait_st2_cnt==3'd3 && we_en ==`WE_ENABLE) begin
				next_state	<=	`we_st3					;
			end
			else begin
				next_state	<=	current_state			;
			end
			
		end
		`we_st3:begin

		/*		TOP1
			if (flag_cs==`FLAG_CS_DISABLE) begin
				next_state	<=	`wait_st2				;
			end
		*/
			if (waddr>=`FULL_ARRARY_TOP2) begin
				next_state	<=	`rd_st					;
			end
			else begin
				next_state	<=	current_state			;
			end

		end
		`rd_st:begin
			if (rd_st_cnt==3'd5) begin
				if (flag_cs==`FLAG_CS_ENABLE) begin
					next_state	<=	`wait_st2				;
				end
				else begin
					next_state	<=	`we_st3					;
				end
			end
			else begin
				next_state	<=	current_state				;
			end
		end	

		default:begin
			next_state	<=	`rst_s0	;
		end
	endcase
end

always@(*)begin

		case(current_state)
		`rst_s0:begin
			rst_cs	<=	`RST_CS_ENABLE	;
			state_o	<=	`rst_s0			;

			rst_cnt_en		<=	`RST_CNT_ENABLE;
			clk_cs_en 		=	`CLK_CS_DISABLE	;
			wait_st2_cnt_en	<=	`CLK_ST2_CNT_DIS;
			rd_st_cnt_en	<=	`RD_ST_CNT_DIS 	;

			cs_o	<= 	`CS_O_DISABLE	;	
		end
		`clk_conf_st1:begin
			rst_cs	<=	`RST_CS_DISABLE	;
			state_o	<=	`clk_conf_st1	;

			rst_cnt_en		<=	`RST_CNT_DISABLE;
			clk_cs_en 		<= 	`CLK_CS_ENABLE	;
			wait_st2_cnt_en	<=	`CLK_ST2_CNT_DIS;
			rd_st_cnt_en	<=	`RD_ST_CNT_DIS 	;

			cs_o	<= 	`CS_O_DISABLE	;	
		end
		`wait_st2:begin
			rst_cs	<=	`RST_CS_DISABLE	;
			state_o	<=	`wait_st2				;

			rst_cnt_en		<=	`RST_CNT_DISABLE;
			clk_cs_en 		<=	`CLK_CS_ENABLE	;
			wait_st2_cnt_en	<=	`CLK_ST2_CNT_EN	;
			rd_st_cnt_en	<=	`RD_ST_CNT_DIS 	;

			cs_o	<= 	`CS_O_DISABLE	;	

		end
		`we_st3:begin			
			rst_cs	<=	`RST_CS_DISABLE	;
			state_o	<=	`we_st3			;
			
			rst_cnt_en		<=	`RST_CNT_DISABLE;
			clk_cs_en 		<=	`CLK_CS_ENABLE	;
			wait_st2_cnt_en	<=	`CLK_ST2_CNT_DIS;
			rd_st_cnt_en	<=	`RD_ST_CNT_DIS 	;

						
			if (waddr>=`FULL_ARRARY_TOP2) begin
				cs_o	<= 	`CS_O_DISABLE	;
			end
			else begin
				cs_o	<= 	`CS_O_ENABLE	;
			end

			//if (flag_cs==`FLAG_CS_DISABLE) begin
		//		waddr	<=	waddr	-	5'd1	;
		//	end

		end
		`rd_st:begin
			rst_cs	<=	`RST_CS_DISABLE	;
			state_o	<=	`rd_st 			;
			
			rst_cnt_en		<=	`RST_CNT_DISABLE;
			clk_cs_en 		<=	`CLK_CS_ENABLE	;
			wait_st2_cnt_en	<=	`CLK_ST2_CNT_DIS;
			rd_st_cnt_en	<=	`RD_ST_CNT_EN 	;

			cs_o	<= 	`CS_O_DISABLE	;			

		end
		default:begin
			rst_cs	<=	`RST_CS_ENABLE	;
			state_o	<=	`rst_s0			;

			rst_cnt_en		<=	`RST_CNT_ENABLE;
			clk_cs_en 		<=	`CLK_CS_DISABLE	;
			wait_st2_cnt_en	<=	`CLK_ST2_CNT_DIS;
			rd_st_cnt_en	<=	`RD_ST_CNT_DIS 	;

			cs_o	<= 	`CS_O_DISABLE	;	
		end
	endcase
end

always @(posedge clk or posedge rst) begin
	if (rst) begin
		inst	<=	4'd0			;
	end
	else if (current_state==`wait_st2) begin
		if (wait_st2_cnt==3'd3 && we_en ==`WE_ENABLE) begin
			inst	<= inst	+	4'd1	;
		end
		else if (inst ==4'd15)begin
			inst	<= 	4'd1	;
		end
		else begin
			inst	<= 	inst		;
		end
	end
	else begin
			inst	<= 	inst		;
	end
end

endmodule
