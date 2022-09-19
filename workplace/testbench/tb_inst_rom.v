module tb_inst_rom;
reg		[3:0]						inst    ;
wire	[7:0]						instrom ;
reg clk;
reg rst;

inst_rom inst_rom1(
	.inst(inst)   ,
	.instrom(instrom)
	
);

always #5 clk = ~clk;

initial begin
	clk =0;
	rst =1;
#30
	rst =0;
#1000
	$stop;	
end
always @(posedge clk or posedge rst) begin
	if (rst) begin
		inst<=0;
	end
	else if(inst==4'd15)begin
		inst<=1;
	end
	else begin
		inst <=inst +1;
	end
end
endmodule
