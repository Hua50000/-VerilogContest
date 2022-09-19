`include "define.v"

module encode(
	input	clk,
	input 	rst,
	input	[3:0]m_seq_paral_in,
	input	d_one,
	output	reg [6:0]hanm_code_out

);
always @(posedge clk or posedge rst) begin
	if (rst) begin
		hanm_code_out<=7'b0;
		
	end
	else if (d_one==`M_SEQ_SUCCESS) begin
		hanm_code_out<={m_seq_paral_in										 ,
						m_seq_paral_in[3]^m_seq_paral_in[2]^m_seq_paral_in[1],
						m_seq_paral_in[3]^m_seq_paral_in[2]^m_seq_paral_in[0],
						m_seq_paral_in[3]^m_seq_paral_in[1]^m_seq_paral_in[0]};
	end
	else begin
		hanm_code_out<=hanm_code_out;
	end
end
endmodule
