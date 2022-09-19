`timescale 1ps/1ns
module keyboard(
	input clk,
	input [16:0] keyb,
	input busy_p,
	input busy_a,
	output [26:0]data1,
	output [26:0]data2,
	output [2:0]arith,
	output en);
	
	reg [16:0] key_reg;
	reg [26:0] data1_reg;
	reg [26:0] data2_reg;
	reg [3:0] data3_reg;
	reg [2:0] arith_reg;
	reg [16:0] key_text;
	reg [16:0] key_try;
	reg en_reg = 0;
	reg a=1;
	
	always@(*)
	begin
		key_reg <= keyb;
	end
	
	always@(*)
	begin
		if (busy_a==0&&busy_p==0)
			begin
				key_try=key_reg;
				key_try=~(key_try|00000001111111111);
				while(key_try);
					begin
						key_reg <= keyb;
						case(key_try)
							17'b11111111111111110: data3_reg = 4'd9;
							17'b11111111111111101: data3_reg = 4'd8;
							17'b11111111111111011: data3_reg = 4'd7;
							17'b11111111111110111: data3_reg = 4'd6;
							17'b11111111111101111: data3_reg = 4'd5;
							17'b11111111111011111: data3_reg = 4'd4;
							17'b11111111110111111: data3_reg = 4'd3;
							17'b11111111101111111: data3_reg = 4'd2; 
							17'b11111111011111111: data3_reg = 4'd1;
							17'b11111110111111111: data3_reg = 4'd0;
						endcase
						data1_reg = data1_reg  * 10 + data3_reg;
					end
				case(key_reg)
					17'b11111011111111111: arith_reg = 3'b100;
					17'b11110111111111111: arith_reg = 3'b011;
					17'b11101111111111111: arith_reg = 3'b010;
					17'b11011111111111111: arith_reg = 3'b001;
					17'b10111111111111111: arith_reg = 3'b000;
				endcase
				if(arith_reg == 3'b100)
					begin
						en_reg = 1 ;
						#200
						en_reg = 0 ;
					end
				else
					begin
						key_try=key_reg;
						key_try=~(key_try|00000001111111111);
						while(key_try);
							begin
								key_reg <= keyb;
								case(key_reg)
									17'b11111111111111110: data3_reg = 4'd9;
									17'b11111111111111101: data3_reg = 4'd8;
									17'b11111111111111011: data3_reg = 4'd7;
									17'b11111111111110111: data3_reg = 4'd6;
									17'b11111111111101111: data3_reg = 4'd5;
									17'b11111111111011111: data3_reg = 4'd4;
									17'b11111111110111111: data3_reg = 4'd3;
									17'b11111111101111111: data3_reg = 4'd2; 
									17'b11111111011111111: data3_reg = 4'd1;
									17'b11111110111111111: data3_reg = 4'd0;
								endcase
								data2_reg = data2_reg  * 10 + data3_reg;
							end
					end
				if(key_reg == 17'b11111110000000000) 
					begin 

						en_reg = 1 ;
						#200
						en_reg = 0 ;
					end
			end			
	end	
	assign data1 = data1_reg;
	assign data2 = data2_reg;
	assign arith = arith_reg;
	assign en = en_reg;
endmodule	