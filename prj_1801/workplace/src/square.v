module sq(
	input rst,
	input signed [26:0] dina,
	output signed [20:0] dout);
	
	reg signed [26:0] dina_reg;
	reg signed [20:0] dout_reg;
	integer i;
	integer b;
	
	always@ (*)
	begin
		dina_reg <= dina;
	end
	
always@(*)begin
	b=dina_reg/2;
	for(i=0;i<100;i=i+1)begin
		if(i*i<=dina_reg)begin
				if((i+1)*(i+1)>dina_reg)
					dout_reg=i;
		end
	end
end
	assign dout[20:0] = dout_reg[20:0];
endmodule	