`include "define.v"
module creat_b(
  input		wire			clk,
  input		wire			rst_n,
  input		wire	[1:0]	data_in_v,
  output	wire	[1:0]	data_out_b
  );
  

reg cnt_between;  //由于只需要判断两个非零码之间的奇偶性，所以设置一个一位二进制计数器即可
reg flag_v;  //记录第一个v码的标志位							 
reg [1:0] data [3:0];  //建立一个位宽为两位的四位移位寄存器

assign  data_out_b = (cnt_between == 0)&&(flag_v == 1)&&(data[0] == 2'b11) ? 2'b10 : data[3];
//当且仅当计数器为偶数且标志位为1时，当输入为一个v码时证明两个输入间存在偶数个非零项，插入b码


always@(posedge clk)begin
	  data[3] <= data[2];
      data[2] <= data[1];
	  data[1] <= data[0];
	  data[0] <= data_in_v;
end

always@(posedge clk or negedge rst_n)begin	
	if(rst_n==`RST_EN)begin
		flag_v <= 1'b0;
		cnt_between <= 1'b0;
	end
	else if(data[0] == 2'b11)begin//检测到输入为11，则将cnt_between清零并且将标志位取反
		cnt_between <= 0;
		flag_v <= ~flag_v;
	end
  	else if(data[0] == 2'b01)begin//检测到输入为01，则cnt_between计数器加一；
	   	cnt_between <= cnt_between + 1'b1;
		flag_v <= flag_v;
	end
  	else begin//其余即输入为零的情况，则使计数器置零，标志位置零即可
		flag_v <= flag_v;
		cnt_between <= cnt_between;
	end
end	


endmodule 
	 
	   
		  
		   
		
	  
  