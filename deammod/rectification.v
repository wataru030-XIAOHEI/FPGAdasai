// module function: Full bridge rectification
//module name : rectification
//author : Wataru030 LPR
`timescale 1ns/1ps
module rectification (
    input clk,
    input rst,
    input signed [11:0] data_in,
    output [11:0] rectification_data_out //整流数据输出
);   
    reg signed [11:0] retification_data_Reg;//全桥整流数据寄存器
//全桥整流 Full bridge rectification
 
    always @(posedge clk) begin
        if(rst)begin
            retification_data_Reg <= 0;
        end
        else begin
            if(data_in[11] == 1'b1)begin
                retification_data_Reg <= -{data_in};
            end
            else begin
				 retification_data_Reg <= data_in;
            end
        end
    end

    assign rectification_data_out = retification_data_Reg;
endmodule //demod