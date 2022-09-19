module remove_v_b(
input     wire           clk,
input     wire           rst_n,
input     wire  [1:0]    data_in,
output    wire  [1:0]    data_out
  );

reg [1:0] data[3:0];  //建立位宽为2的四位移位寄存器

assign data_out = data[3];
always@(posedge clk or negedge rst_n)
 begin
  if(!rst_n)
    begin
	  //data_out <= 0;
     data[3] <= 0;
     data[2] <= 0; 
     data[1] <= 0;
	   data[0] <= 0;
	 end
  else if(data_in == 2'b11) //若第四三位出现v脉冲，则使移位寄存器中四位数据全部清零
    begin
	  //data_out <= 0;
     data[3] <= 0;
     data[2] <= 0; 
     data[1] <= 0;
	  data[0] <= 0;	
	  
	 end
  else
    begin
	  //data_out <= data[3];
     data[3] <= data[2];
     data[2] <= data[1]; 
     data[1] <= data[0];
     data[0] <= data_in; 
    end  
 end

 //assign data_out = () ? data[3]:2'b00 
 //assign data_out = data[3];

endmodule