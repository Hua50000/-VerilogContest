//STATE STATUES 全局
`define rst_s0			3'd0
`define clk_conf_st1	3'd1
`define wait_st2		3'd2
`define	we_st3			3'd3
`define	rd_st			3'd4

`define RST_CS_ENABLE	1'b0
`define RST_CS_DISABLE 	1'b1

`define RST_CNT_ENABLE	1'b1
`define RST_CNT_DISABLE	1'b0

`define CLK_CS_ENABLE	1'b1
`define	CLK_CS_DISABLE	1'b0

`define CLK_ST2_CNT_EN	1'b1
`define CLK_ST2_CNT_DIS	1'b0

`define RD_ST_CNT_EN	1'b1
`define RD_ST_CNT_DIS	1'b0

`define WE_ENABLE		1'b1
`define	WE_DISABLE		1'b0

`define FLAG_CS_ENABLE	1'b1
`define FLAG_CS_DISABLE	1'b0

`define	CS_O_ENABLE		1'b0
`define	CS_O_DISABLE	1'b1

`define FULL_ARRARY_TOP2 4'd8
`define FULL_ARRARY_TOP3 4'd5