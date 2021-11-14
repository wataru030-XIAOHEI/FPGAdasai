//clk : 27MHZ
//module function :调节载波频率
module ket_ctrl(
    input clk ,
    input ctrl_key_add,
    input ctrl_key_sub,
    input rst,
    output[9:0] addr_change
);
    parameter cnt_max = 40'd270_000;
    reg[39:0] check_cnt;// max:134999 ,5ms
    wire key_enable_pre;
    reg key_enable_add;
    reg key_enable_sub;
    reg[9:0] addr_change_reg;
    assign key_enable_pre = (~ctrl_key_add) | (~ctrl_key_sub);
    always @(posedge clk)begin
		if(rst)
			check_cnt <= 20'd0;
		else if(key_enable_pre == 1) begin
			if(check_cnt == cnt_max)
				check_cnt <= check_cnt;
			else 
				check_cnt <= check_cnt + 1'b1;
			end
		else
			check_cnt <= 40'd0;
	end
    always @(posedge clk) begin
		if(rst)  begin key_enable_add <= 1'd0;key_enable_sub <= 1'b0; end
		else if(!ctrl_key_add)  key_enable_add <= (check_cnt == cnt_max -1 ) ? 1'b1 : 1'b0;
        else if(!ctrl_key_sub) key_enable_sub <= (check_cnt == cnt_max -1 ) ? 1'b1 : 1'b0;
		else begin key_enable_add <= key_enable_add;key_enable_sub <= key_enable_sub;end
	end

    always @(posedge clk) begin
        if (rst) begin
            addr_change_reg <= 10'd0;
        end
        else begin
            addr_change_reg <= (key_enable_add)? addr_change_reg+ 10'd5 
                                            :           (key_enable_sub)? addr_change_reg - 10'd5 
																								:addr_change_reg ;
                      
          end                                  
    end
    assign addr_change = addr_change_reg ;
endmodule



