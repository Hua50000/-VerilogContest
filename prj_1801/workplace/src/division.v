`timescale 1ns/1ps

module division(
		input rst,
		input signed [15:0] dina,
		input signed [15:0] dinb,
		output signed [15:0] dout,
		output signed [15:0] dout_1	
);
reg signed [15:0] dina_reg;
reg signed [15:0] dinb_reg;
reg signed [15:0] dout_quotient_reg;
reg signed [15:0] dout_remainder_reg;
//进数
always@(*)
begin
		if(!rst)
			begin
				dina_reg<=0;
				dinb_reg<=0;
			end
		else
			begin	
				dina_reg<=dina;
				dinb_reg<=dinb;
			end
end

always@(*)
begin
	if(!rst)
		begin
			dout_quotient_reg<=0;
			dout_remainder_reg<=0;
		end
	else
		begin
			dout_quotient_reg<=dina_reg/dinb_reg;
			dout_remainder_reg<=dina_reg%dinb_reg;
		end
end

assign dout=dout_quotient_reg;
assign dout_1=dout_remainder_reg;

endmodule
