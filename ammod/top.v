//DSB
module top (
    input clk,
    input ctrl_key_add,
    input ctrl_key_sub,
    output clk_dac,
	output  clk_adc,
    input rst,
	input signed[7:0] data_in,
    output signed  [7:0] ammod_wave

);
parameter madata =255;
//-------------------------------------------
	reg[7:0] data_in_temp;
	wire signed [15:0] ammul_o_temp ;
	reg signed [15:0] ammul_o_temp2;
	wire signed [15:0]ammul_o_temp3;
	wire  clk_dac_reg;
    //wire [7:0] modelwave;

	//wire signed[8:0] ma  = madata;//调制系数 0.75
	//reg [7:0] maxsin_with_dc ;
	//wire[15:0] maxsin16bits;
	//wire[7:0] maxsin8bits;
    wire [7:0] carrier_reg;
	wire signed[7:0] carrier;
    wire [9:0] addr_change;
    wire signed[15:0] ammul_o;
//------------------------------------------
	wire clk_model_signal;
//-=------------------------------------------
	wire signed[8:0] filter_o;

//------------------
	always@(posedge clk_adc)begin
		data_in_temp <= data_in;
	end
    //时钟
    Gowin_PLLVR gobalpll(
        .clkout(clk_dac_reg), //output clkout
        .clkin(clk) //input clkin
    );
	assign clk_adc  = clk;
	assign clk_dac = clk;
//    Gowin_CLKDIV clkdivforModelSignal(
//        .clkout(clk_model_signal), //output clkout
//        .hclkin(clk), //input hclkin
//        .resetn(1'b1) //input resetn
//    );
    //模拟信号发生器 DDS
//    modelsignal u_modelsignal(
//        .clk   ( clk_model_signal   ),
//        .rst_n ( rst_n ),
//        .modelwave  ( modelwave  )
//    );

//调制系数x输入信号  ma*sinwt
//    Gowin_MULT maxsin(
//        .dout(maxsin16bits), //output [15:0] dout
//        .a(ma[7:0]), //input [7:0] a,调制系数
//        .b(data_in), //input [7:0] b
//        .ce(1'b1), //input ce
//        .clk(clk), //input clk
//        .reset(rst_n) //input reset
//		
//    );
//	assign maxsin8bits  = maxsin16bits [15:8];
//	always@(posedge clk)begin
//			 maxsin_with_dc <= maxsin8bits ;
//	end
    //按键控制
    ket_ctrl u_ket_ctrl(
        .clk      ( clk      ),
        .ctrl_key_add(ctrl_key_add),
        .ctrl_key_sub(ctrl_key_sub),
        .rst      ( rst      ),
        .addr_change  ( addr_change  )
    );

    //载波
    carriergen carriergenmod(
        .clk   ( clk   ),
        .rst( rst ),
        .addr_change(addr_change),
        .carrier  ( carrier  )
    );
    //乘法模块 
    Gowin_MULT ammodmul(
        .dout(ammul_o_temp), //output [15:0] dout
        .a(data_in_temp), //input [7:0] a
        .b(carrier), //input [7:0] b
        .ce(1'b1), //input ce
        .clk(clk), //input clk
        .reset(rst) //input reset
    );	
	assign ammod_wave =ammul_o_temp[15:8] + 8'd127;// ammul_o_temp[15:8];
endmodule //top