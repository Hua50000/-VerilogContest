`include "define.v"
module wdata(
	input	wire							clk_cs,
	input 	wire 							rst	,
	input	wire							cs_o,
	input	wire [7:0]					instrom,

	output	reg								dacs,
	output	reg	 [3:0]						waddr1

	);
reg [3:0]waddr;
always @(posedge clk_cs or posedge rst) begin
	if (rst) begin
		dacs	<= 1'b0;
		waddr	<=	4'b0;
		waddr1	<=	4'b0;
	end
	else if (cs_o==`CS_O_ENABLE) begin
		dacs	<=	instrom[3'd7-waddr];
		waddr	<=	waddr	+ 4'd1;
		waddr1	<=	waddr;
	end
	else begin
		dacs	<= 1'b0;
		waddr	<=	4'b0;
		waddr1	<=	4'b0;
	end
end
endmodule
