`include "define.v"

module bit_change(
  input   wire        clk,
  input   wire  [1:0] data_in,
  output  reg         data_out
  );

/*
将最终去除b、v信号的输出信号从两位数据
转换为0/1的一位数据准备叠加后输出
*/
always@(posedge clk)begin
  if(data_in == 2'b01)begin
    data_out <= 1'b1;
  end  
	else begin
     data_out <= 1'b0; //此时数据中仅有0/1的排列
  end
end                       

endmodule