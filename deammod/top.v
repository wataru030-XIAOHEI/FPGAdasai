module top (
    input clk,
    //input clk_27mhz,
    input rst,
    input signed [11:0] data_in,
    output wire [ 13:0] data_o,
    //dac clk,<125mhz
    output clk_dac,
    //adc clk , <65MHZ
    output clk_adc
);
    //模块中使用端口
    wire signed [31:0] filter_temp;
    wire signed[11:0] rectification_temp;
    wire clk_filter;
    wire clk_dac_reg;
    wire clk_adc_reg;
//时钟
    addc_clk clk_gen(
        .clkout(clk_dac_reg), //output clkout_dac 100mhz
        .clkoutd(clk_adc_reg), //output clkoutd_Adc,62.5mhz
        .clkin(clk) //input clkin
    );
    assign clk_dac = clk_dac_reg;
    assign clk_adc = clk_adc_reg;
//全桥整流

    rectification u_rectification(
        .clk     ( clk     ),
        .rst     ( rst     ),
        .data_in ( data_in ),
        .rectification_data_out  ( rectification_temp  )
    );
//滤波&滤波时钟
clk50to1 clk_filtermod(
									.clk(clk),
									.clk_1mhz(clk_filter),//output 1mhz clk 
									.rst(rst)
);
    filter_3k4 u_filter_3k4(
        .clk        ( clk_filter        ),
        .clk_enable ( 1'b1 ),
        .reset      ( rst      ),
        .filter_in  ( rectification_temp  ),
        .filter_out  ( filter_temp  )
    );


    assign data_o = filter_temp[30:17] ;//- 14'd8191;
endmodule //top