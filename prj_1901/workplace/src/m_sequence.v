`include "define.v"
module m_sequence
#(
	parameter	N=4'd8			,
	parameter 	POLY = 3'b101	
)
(

input clk,

input rst_n,

output wire m_seq

);

//由本原多项式得到

 
reg [N-4'd1:0] shift_reg;

 
always@(posedge clk or negedge rst_n)begin

	if(rst_n == 0)begin

		shift_reg <= 3'b111;//初值不可为全零

	end

	else begin

		shift_reg[2] <= (shift_reg[0] & POLY[2])^

		(shift_reg[1] & POLY[1])^

		(shift_reg[2] & POLY[0]);

		/*(shift_reg[3] & POLY[4])^

		(shift_reg[4] & POLY[3])^

		(shift_reg[5] & POLY[2])^

		(shift_reg[6] & POLY[1])^

		(shift_reg[7] & POLY[0])	;*/

		shift_reg[1:0] <= shift_reg[2:1];

	end

end

 
assign m_seq = shift_reg[0];

 
endmodule