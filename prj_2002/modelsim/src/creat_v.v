`include "define.v"
module creat_v(
  input		wire			clk,
  input		wire			rst_n,
  input		wire			data_in,
  output	reg		[1:0]	data_out_v
  );
  

reg [1:0] data_out_v;
reg [1:0] cnt_0;   //计数器，用于记录输入数据连续0的个数   

//编码
//输出0: 2'b00
//输出1: 2'b01
//插入v: 2'b11

always@(posedge clk or negedge rst_n)begin
	if(rst_n==`RST_EN)begin
	 	cnt_0 <= 2'b00;
		data_out_v <= 2'b00;
    end
  	else if(data_in == 1'b1)begin
	   	cnt_0 <= 0;
		data_out_v <= 2'b01;
	end
  	else begin
		if(cnt_0 == 2'b11)begin
			data_out_v <= 2'b11;
			cnt_0 <= 2'b00;
		end
		else begin
			data_out_v <= 2'b00;
			cnt_0 <= cnt_0 + 1'b1;
		end
	end
end
endmodule
		  