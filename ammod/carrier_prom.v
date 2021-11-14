//Copyright (C)2014-2021 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//GOWIN Version: V1.9.8
//Part Number: GW1NSR-LV4CQN48PC7/I6
//Device: GW1NSR-4C
//Created Time: Tue Nov 09 00:58:21 2021

module carrier_prom (dout, clk, oce, ce, reset, ad);

output [7:0] dout;
input clk;
input oce;
input ce;
input reset;
input [7:0] ad;

wire [23:0] prom_inst_0_dout_w;
wire gw_gnd;

assign gw_gnd = 1'b0;

pROM prom_inst_0 (
    .DO({prom_inst_0_dout_w[23:0],dout[7:0]}),
    .CLK(clk),
    .OCE(oce),
    .CE(ce),
    .RESET(reset),
    .AD({gw_gnd,gw_gnd,gw_gnd,ad[7:0],gw_gnd,gw_gnd,gw_gnd})
);

defparam prom_inst_0.READ_MODE = 1'b0;
defparam prom_inst_0.BIT_WIDTH = 8;
defparam prom_inst_0.RESET_MODE = "SYNC";
defparam prom_inst_0.INIT_RAM_00 = 256'h585653514E4C494744413F3C393634312E2B2825221F1C191613100C09060300;
defparam prom_inst_0.INIT_RAM_01 = 256'h7F7F7F7E7E7E7D7D7C7B7B7A79787776747372706F6D6C6A68666462605E5C5A;
defparam prom_inst_0.INIT_RAM_02 = 256'h5B5D6062646567696B6C6E7071727475767778797A7B7C7C7D7E7E7E7F7F7F7F;
defparam prom_inst_0.INIT_RAM_03 = 256'h0205080B0E1114181B1E2124272A2D2F3235383B3E404346484B4D5052555759;
defparam prom_inst_0.INIT_RAM_04 = 256'hA7A9ACAEB1B3B6B8BBBDC0C3C6C8CBCED1D4D7DADDE0E3E6E9ECEFF2F5F8FCFF;
defparam prom_inst_0.INIT_RAM_05 = 256'h8181818182828383848485868788898A8B8C8E8F9192949597999B9D9FA1A3A5;
defparam prom_inst_0.INIT_RAM_06 = 256'hA6A4A19F9D9B9A9896949391908E8D8C8A898887868585848383828282818181;
defparam prom_inst_0.INIT_RAM_07 = 256'h00FCF9F6F3F0EDEAE7E4E1DEDBD8D5D2CFCCC9C6C4C1BEBCB9B6B4B1AFADAAA8;

endmodule //carrier_prom
