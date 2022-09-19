module transfer_1to4(
    input   clk,
    input   rst_n,
    input   d_in,

    output reg      [1:0]I_req,
    output reg      [1:0]Q_req,
    output reg      [3:0]d_out,
    output          [3:0]d_out2,
    output reg           d_one
);

    reg [1:0]   cnt;
    reg         d_one_1;
    reg [3:0]   d_out_1;
always @(posedge clk or posedge rst_n) begin
    if (rst_n) begin
        I_req<=2'b0;
        Q_req<=2'b0;
        
    end
    else if (d_one_1) begin
        I_req<={d_out2[2],d_out2[0]};
        Q_req<={d_out2[3],d_out2[1]};
    end
    else begin
        I_req<=I_req;
        Q_req<=Q_req;
    end
end

assign  d_out2={d_out[0],d_out[1],d_out[2],d_out[3]};

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            d_out_1 <= 4'b0;
        end
        else begin
            d_out_1[cnt] <= d_in;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            d_out <= 4'b0;
        end
        else if (d_one_1) begin
            d_out <= d_out_1;
            d_one <= d_one_1;
        end
        else begin
            d_out <= 4'b0;
            d_one <= d_one_1;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            cnt <= 2'b0;
            d_one_1 <= 1'b0;
        end
        else if(cnt == 2'b11) begin
            cnt <= 2'b0;
            d_one_1 <= 1'b1;
        end
        else begin
            cnt <= cnt + 1'b1;
          d_one_1 <= 1'b0;
        end
    end

endmodule