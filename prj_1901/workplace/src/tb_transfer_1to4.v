`timescale 1ns/1ns
module tb_transfer_1to4;
    
    reg clk;
    reg rst_n;
    reg d_in;
    wire [3:0]d_out;
    wire d_one;

    transfer_1to4 t1(
    clk,rst_n,d_in,d_out,d_out2,d_one
);
    initial begin
        clk = 1'b1;
        rst_n = 1'b0;
        #10;
        rst_n = 1'b1;
        #1000
        $stop;
    end

    always #5 clk = ~clk;
    initial begin
        repeat(16) begin
            #10;
            d_in = {$random}%2;
        end
    end
endmodule