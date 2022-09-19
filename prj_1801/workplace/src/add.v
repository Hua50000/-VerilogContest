`timescale 1ps/1ps

module add(
		input rst,
		input signed [15:0] dina,
		input signed [15:0] dinb,
		output signed [15:0] dout	
);

reg signed [15:0] dina_reg;
reg signed [15:0] dinb_reg;
reg signed [15:0] dout_reg;

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
			dout_reg<=0;
	else
			dout_reg<=dina_reg + dinb_reg;
end

assign dout = dout_reg;

endmodule