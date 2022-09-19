`include "define.v"
module m_sequence
#(
	parameter	N=4'd4			,
	parameter 	POLY = 4'b1100	
)
(

input clk,

input rst,

output wire m_seq

);

//由本原多项式得到

 
reg [N-4'd1:0] shift_reg;

 
always@(posedge clk or negedge rst)begin

	if(rst )begin

		shift_reg <= 4'b1000;//初值不可为全零

	end

	else begin

		shift_reg[3] <= (shift_reg[0] & POLY[3])^

		(shift_reg[1] & POLY[2])^

		(shift_reg[2] & POLY[1])^

		(shift_reg[3] & POLY[0]);

		/*(shift_reg[4] & POLY[3])^

		(shift_reg[5] & POLY[2])^

		(shift_reg[6] & POLY[1])^

		(shift_reg[7] & POLY[0])	;*/

		shift_reg[2:0] <= shift_reg[3:1];

	end

end

 
assign m_seq = shift_reg[0];

 
endmodule