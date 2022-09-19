module m_sequence
#(
 parameter N=4'd8  ,
 parameter  POLY = 8'b10001110
)
(
input clk,
input rst_n,
output wire m_seq
);

//由本原多项式得到

 
reg [N-4'd1:0] shift_reg;

always@(posedge clk or negedge rst_n)
begin

 if(!rst_n)
   begin

  shift_reg <= 4'b1000;//初值不可为全零

 end

 else begin

  shift_reg[7] <= (shift_reg[0] & POLY[7])^

  (shift_reg[1] & POLY[6])^

  (shift_reg[2] & POLY[5])^

  (shift_reg[3] & POLY[4])^

  (shift_reg[4] & POLY[3])^

  (shift_reg[5] & POLY[2])^

  (shift_reg[6] & POLY[1])^

  (shift_reg[7] & POLY[0]) ;

  shift_reg[6:0] <= shift_reg[7:1];

 end

end
 
assign m_seq = shift_reg[0];
 
endmodule