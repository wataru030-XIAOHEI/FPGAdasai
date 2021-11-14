//1MHZ
module clk50to1(
									clk,
									clk_1mhz,
									rst);

	input clk;
	input rst;
	output  clk_1mhz;
	reg[5:0] cnt;
	reg clk_temp;
	always@(posedge clk)begin
		if(rst)begin
			clk_temp <= 0;
			cnt <= 6'd0;
		end
		else begin
			if(cnt == 6'd49)begin
				clk_temp <= ~clk_temp;
				cnt <= 6'd0;
			end
			else begin
				cnt <= cnt + 1'b1;
			end
	end
	end
	assign clk_1mhz = clk_temp;
endmodule