module calculat(
	input clk,
	input signed [26:0] data1,
	input signed [26:0] data2,
	input en,
	input signed [2:0] arith,
	output signed [53:0] data3,
	output data_latch,
	output busy);
	
	reg signed [26:0] dina_reg;
	reg signed [26:0] dinb_reg;
	reg signed [53:0] dout_reg;
	reg signed [2:0] arith_reg;
	reg en_reg;
	reg rst;
	reg busy_reg;
	reg data_latch_reg=0;
	reg result1;
	reg result2;
	reg result3;
	reg result4;
	reg result5;
	
	add(
		dina(dina_reg),
		dinb(dinb_reg),
		dout(result1)
	);
	
	subteact(
		dina(dina_reg),
		dinb(dinb_reg),
		dout(result2)
	);
		
	multiply(
		dina(dina_reg),
		dinb(dinb_reg),
		dout(result3)
	);
		
	division(
		dina(dina_reg),
		dinb(dinb_reg),
		dout(result4)
	);
		
	square(
		dina(dina_reg),
		dout(result5)
	);
		
	
	
	always@(*)
	begin
		dina_reg = data1;
		dinb_reg = data2;
		arith_reg = arith;
		en_reg=en;
		case(arith_reg)
			3'b000: dout_reg=result1;
			3'b001: dout_reg=result2;
			3'b010: dout_reg=result3;
			3'b011: dout_reg=result4;
			3'b100: dout_reg=result5;
		endcase
		#1000
		data_latch_reg = 1;
	end
	assign data3 = dout_reg;
	assign busy = busy_reg;
	assign data_latch = data_latch_reg;
endmodule