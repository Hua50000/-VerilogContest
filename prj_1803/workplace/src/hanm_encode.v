module hanm_encode(
	input	clk,
	input	rst,

	input   [6:0]hanm_code_with_noise,
	output	[3:0]hanm_dec_out_paral,
	output	ne,
	output	reg	[2:0]error_pointer

	);
reg	[2:0]	S;

assign ne = (error_pointer==3'b111)? 1'b0:1'b1	;
assign hanm_dec_out_paral = hanm_code_with_noise[6:3];
always @(*) begin
	case(S)
	3'b001:error_pointer<=3'b000;
	3'b010:error_pointer<=3'b001;
	3'b100:error_pointer<=3'b010;
	3'b011:error_pointer<=3'b011;
	3'b101:error_pointer<=3'b100;
	3'b110:error_pointer<=3'b101;
	3'b111:error_pointer<=3'b110;
	3'b000:error_pointer<=3'b111;
	default:error_pointer<=3'b111;
	endcase
end


always @(negedge clk or posedge rst) begin
	if (rst) begin
		S<=3'b0;
		
	end
	else begin
		S<={hanm_code_with_noise[6]^hanm_code_with_noise[5]^hanm_code_with_noise[4]^hanm_code_with_noise[2],
			hanm_code_with_noise[6]^hanm_code_with_noise[5]^hanm_code_with_noise[3]^hanm_code_with_noise[1],
			hanm_code_with_noise[6]^hanm_code_with_noise[4]^hanm_code_with_noise[3]^hanm_code_with_noise[0]
		};
	end
end
endmodule
