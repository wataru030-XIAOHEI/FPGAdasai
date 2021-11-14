module carriergen (
    input               clk,
    input               rst,
    input[9:0]     addr_change,
    output [7:0]    carrier
);
    parameter freq_car = 10'd40;
//-----------------------
	wire[7:0]carrier_reg;
    reg[9:0] cnt;
    wire [7:0] addr_car ;
    always @(posedge clk) begin
        if (rst) begin
            cnt <= 10'd0;
        end
        else begin
            cnt <= cnt + freq_car + addr_change;
        end
    end
    assign addr_car = cnt[9:2];
  carrier_prom carriergenProm(
        .dout(carrier_reg), //output [7:0] dout
        .clk(clk), //input clk
        .oce(1'b1), //input oce
        .ce(1'b1), //input ce
        .reset(rst), //input reset
        .ad(addr_car) //input [7:0] ad
    );
	assign carrier = carrier_reg;
endmodule //carriergen