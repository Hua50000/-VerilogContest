`include "define.v"
module inst_rom(
	input 		[3:0]						inst   ,
	output reg	[7:0]						instrom
	
);

	reg[7:0]  inst_mem[0:15];

	initial $readmemh ( "F:/prj/prj_1902/workplace/data/inst_rom1.data", inst_mem );

	always @ (*) begin
		  instrom<= inst_mem[inst-4'd1];

		end

endmodule