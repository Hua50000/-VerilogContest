`timescale 1ns/1ps

module multiply(rst,dina,dinb,dout);
		input rst;
		input signed [3:0] dina;
		input signed [3:0] dinb;
		output signed [7:0] dout;	


reg [7:0] dout;
reg [3:0] i;

//进数
always@(*)
begin
		if(!rst)
			begin
				dout=0;
			end
		else
			begin	
				dout=0;
				for(i=0;i<=3;i=i+1)
					if(dinb[i])
						dout = dout + (dina<<i);
			end
end

endmodule
