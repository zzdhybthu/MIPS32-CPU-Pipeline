`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/02 18:10:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: Test_CPU
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2017.4
// Description: Test CPU
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


`define PERIOD 10
`define BAUD_PERIOD 1000000000 / 9600

module Test_CPU (

);
reg clk, rst;
wire [6:0] Seg;
wire Dot;
wire [3:0] Sel;
reg RxSerial;
wire TxSerial;

reg [9:0] byte_index;
reg [3:0] bit_index;

CPU cpu (
    .rst(rst),
    .sysclk(clk),
    .RxSerial(RxSerial),
    .Seg(Seg),
    .Dot(Dot),
    .Sel(Sel),
    .TxSerial(TxSerial)
);

// parameter [671:0] tb_data = 672'h00000014_000041A8_00003AF2_0000ACDA_00000C2B_0000B783_0000DAC9_00008ED9_000009FF_00002F44_0000044E_00009899_00003C56_0000128D_0000DBE3_0000D4B4_00003748_00003918_00004112_0000C399_00004955;
parameter [63:0] tb_data = 64'h00000001_FEDCBA98;  // for faster simulation

// for test
reg [7:0] byte_to_send;

initial begin
    clk = 1'b0;
    rst = 1'b0;
    RxSerial = 1'b1;
    byte_index = 10'd0;
    bit_index = 4'd0;

    // while (byte_index < 84) begin
    while (byte_index < 8) begin
        RxSerial = 0;
        #(`BAUD_PERIOD);
        while (bit_index < 8) begin
            // RxSerial = tb_data[(83 - byte_index) * 8 + bit_index];
            RxSerial = tb_data[(7 - byte_index) * 8 + bit_index];
            #(`BAUD_PERIOD);
            bit_index = bit_index + 1;
        end
        RxSerial = 1;
        bit_index = 0;
        byte_index = byte_index + 1;
        #(`BAUD_PERIOD);
    end

end

always #(`PERIOD / 2) clk = ~clk;


endmodule