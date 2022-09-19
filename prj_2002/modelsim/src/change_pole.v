`include "define.v"

module change_pole(
  input 	wire			clk,
  input		wire			rst_n,
  input		wire	[1:0]	data_in_b,
  output	reg				BP,
  output	reg				BN
  );
  
reg [1:0] polar_out;

reg even;  //符号标志位,even = 1,证明前一项非零位为负数


/*
//转换
//对于v码，由于极性与前一项非零项极性相同
//所以当even == 1时，v码转换为01，代表-1
//even == 0时，v码转换为11，代表+1
//对于非零码以及b码，遵循相同规则，即与前一项符号相反
//所以当even == 1时，b码或非零码转换为11，代表+1
//even == 0时，b码或非零码转换为01，代表-1
//最终的输出正负脉冲BN、BP根据polar_out的值进行对应
//当polar_out == 01,即代表-1,所以BN = 1（负脉冲）
//当polar_out == 11,即代表+1,所以BP = 1（正脉冲）
*/
always@(posedge clk or negedge rst_n)begin
    if(rst_n==`RST_EN)begin
		  even <= 1'b0;
		  polar_out <= 2'b0;
	end
	else if(data_in_b == 2'b11)begin 	//检测v码极性
		if(even == 1)begin
			polar_out <= 2'b01;	//-1
		end
		else begin  
			polar_out <= 2'b11;	//+1
		end
	end
	else if(data_in_b == 2'b01 || data_in_b == 2'b10)begin//检测到非零码和b码时
		if(even == 1)begin
			even <= 0;  //将符号标志位取反
			polar_out <= 2'b11;  //+1
		end
		else begin
			even <= 1;
			polar_out <= 2'b01;  //-1
		end
	end
	else begin
		polar_out <= 2'b00;
	end
end


always @(*)begin
    if(polar_out == 2'b01)  begin
		BP <= 1;
		BN <= 0;
	end
	else if(polar_out == 2'b11)begin
		BP <= 0;
		BN <= 1;
	end
	else begin
		BP <= 0;
		BN <= 0;
	end
end
endmodule				
			 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 