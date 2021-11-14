module modelsignal (
    input  wire clk ,
    input rst_n,
    output[7:0] modelwave
);
    parameter freq = 10'd1;//about 53KHz
    reg [9:0] cnt;
    wire [7:0] addr;
    wire [7:0] dout_o;
    always @(posedge clk) begin
        if (rst_n) begin
            cnt <= 10'd0;
        end
        else begin
            cnt <= freq + cnt;
        end
    end
    assign addr = cnt[9:2];
    Gowin_pROM modelsignalgen(
            .dout(dout_o), //output [7:0] dout
            .clk(clk), //input clk
            .oce(1'b1), //input oce
            .ce(1'b1), //input ce
            .reset(rst_n), //input reset
            .ad(addr) //input [7:0] ad
        );
        assign modelwave = dout_o ;
endmodule //modelsignal