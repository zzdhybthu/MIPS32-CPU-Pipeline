`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/01 21:51:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: IF_ID
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2017.4
// Description: IF/ID Register
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module IF_ID (
    input rst,
    input clk,
    input [1:0] HzCtrl, // 00: normal, 01: flush, 10: stall
    input [31:0] PC4,
    input [31:0] Inst,
    output reg [4:0] IF_ID_RsAddr,
    output reg [4:0] IF_ID_RtAddr,
    output reg [4:0] IF_ID_RdAddr,
    output reg [15:0] IF_ID_Imm,
    output reg [5:0] IF_ID_OpCode,
    output reg [5:0] IF_ID_Funct,
    output reg [25:0] IF_ID_JumpAddr,
    output reg [31:0] IF_ID_PC4
);


initial begin
        IF_ID_RsAddr <= 5'h00;
        IF_ID_RtAddr <= 5'h00;
        IF_ID_RdAddr <= 5'h00;
        IF_ID_Imm <= 16'h0000;
        IF_ID_OpCode <= 6'h00;
        IF_ID_Funct <= 6'h00;
        IF_ID_JumpAddr <= 26'h0000000;
        IF_ID_PC4 <= 32'h00000000;
end

always @(posedge clk or posedge rst) begin
    if (rst || HzCtrl == 2'b01) begin
        IF_ID_RsAddr <= 5'h00;
        IF_ID_RtAddr <= 5'h00;
        IF_ID_RdAddr <= 5'h00;
        IF_ID_Imm <= 16'h0000;
        IF_ID_OpCode <= 6'h00;
        IF_ID_Funct <= 6'h00;
        IF_ID_JumpAddr <= 26'h0000000;
        IF_ID_PC4 <= 32'h00000000;
    end
    else if (HzCtrl == 2'b00) begin
        IF_ID_RsAddr <= Inst[25:21];
        IF_ID_RtAddr <= Inst[20:16];
        IF_ID_RdAddr <= Inst[15:11];
        IF_ID_Imm <= Inst[15:0];
        IF_ID_OpCode <= Inst[31:26];
        IF_ID_Funct <= Inst[5:0];
        IF_ID_JumpAddr <= {PC4[31:28], Inst[25:0], 2'b00};
        IF_ID_PC4 <= PC4;
    end
end

endmodule