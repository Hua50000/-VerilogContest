module noisy(
	input	clk,
	input 	rst,
	input	[2:0]s,
	
	output	reg	[6:0]noise

	);

always @(posedge clk or posedge rst) begin
	if (rst) begin
		noise<=7'b0;
		
	end
	else begin
		case(s)
			3'b000:noise<=7'b0000001;
			3'b001:noise<=7'b0000010;
			3'b010:noise<=7'b0000100;
			3'b011:noise<=7'b0001000;
			3'b100:noise<=7'b0010000;
			3'b101:noise<=7'b0100000;
			3'b110:noise<=7'b1000000;
			default:noise<=7'b1100000;

		endcase
	end
end
endmodule
