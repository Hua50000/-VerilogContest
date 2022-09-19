`include "define.v"
module check_v(
  input 	wire				clk,
  input		wire				rst_n,
  input		wire				P,
  input		wire				N,
  output 	wire	[1:0]		out_v1,
  output 	wire	[1:0]		out_v2
 );
  

reg [1:0] cnt_1; 
reg [1:0] cnt_2; 
reg 	  P_reg2;
reg 	  N_reg2;
reg [1:0] out_v1q[1:0] ; //-v鑴夊啿閫氶亾杈撳嚭
reg [1:0] out_v2q[1:0] ; //+v鑴夊啿閫氶亾杈撳嚭



assign out_v1 = out_v1q[1];
assign out_v2 = out_v2q[1];

always @(posedge clk or negedge rst_n) begin
	if (rst_n==`RST_EN) begin
		cnt_1<=0;
		out_v1q[0] <= 2'b00;
	end

	else if (N==1&&cnt_1!=2) begin
		cnt_1<=0;
		out_v1q[0] <= P;
		out_v1q[1] <= out_v1q[0];
	end
	else if (N==1&&cnt_1==2) begin
		cnt_1<=0;
		out_v1q[1] <= 2'b11;
		out_v1q[0] <= P;
	end
	else begin
		if(cnt_1==2)begin
			out_v1q[1] <= 2'b11;
			cnt_1<=0;
			out_v1q[0] <= P;
		end	
		else if (P==1) begin
			cnt_1 <= cnt_1 + 1'b1;
			out_v1q[0] <= P;
			out_v1q[1] <= out_v1q[0];
		end 
		else begin
			cnt_1 <= cnt_1 ;
			out_v1q[0] <= P;
			out_v1q[1] <= out_v1q[0];
		end

	end
end

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		cnt_2<=0;
		out_v2q[0] <= 2'b00;
	end

	else if (P==1&&cnt_2!=2) begin
		cnt_2<=0;
		out_v2q[0] <= N;
		out_v2q[1] <= out_v2q[0];
	end
	else if (P==1&&cnt_2==2) begin
		cnt_2<=0;
		out_v2q[1] <= 2'b11;
		out_v2q[0] <= N;
	end
	else begin
		if(cnt_2==2)begin
			out_v2q[1] <= 2'b11;
			cnt_2<=0;
			out_v2q[0] <= N;
		end	
		else if (N==1) begin
			cnt_2 <= cnt_2 + 1'b1;
			out_v2q[0] <= N;
			out_v2q[1] <= out_v2q[0];
		end 
		else begin
			cnt_2 <= cnt_2 ;
			out_v2q[0] <= N;
			out_v2q[1] <= out_v2q[0];
		end

	end
end


endmodule
