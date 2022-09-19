`timescale 1ns/1ns
module tb_wdata;
reg						clk_cs;
reg						rst	;
reg						cs_o;
reg [7:0]				instrom;

wire							dacs;
wire	 [3:0]					waddr;
reg clk;
reg cs_o1;
wdata wdata0(
	.clk_cs(clk_cs),
	.rst(rst)	,
	.cs_o(cs_o),
	.instrom(instrom),
	.dacs(dacs),
	.waddr(waddr)

	);
always #20 clk_cs = ~clk_cs;
always #5 clk = ~clk;
initial begin
	clk_cs =0;
	clk=0;
	rst =1;
	cs_o=1;
	cs_o1=1;
	instrom=8'b0;
#20
	rst=0;
#10
	instrom=8'b10101101;
#20
cs_o=0;
cs_o1=0;

#1000
	//cs_o=0;
#40
	instrom=8'b10101101;
	cs_o=0;
	cs_o1=0;

#1000
	//cs_o=0;	
	$stop;	
end
always @(posedge clk) begin
	if(waddr==4'd8)begin
		cs_o1<=1;	
		cs_o<=cs_o1;
	end
	else begin
		cs_o1<=cs_o1;
		cs_o<=cs_o;
	end
end

endmodule
