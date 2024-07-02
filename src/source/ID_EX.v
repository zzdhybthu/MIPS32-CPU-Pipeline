`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/01 20:47:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: ID_EX
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2018.3
// Description: ID/EX Register
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module ID_EX (
    input rst,
    input clk,
    input [1:0] HzCtrl, // 00: normal, 01: flush, 10: stall
    input [1:0] PCSrc,
    input [31:0] Rs,
    input [31:0] Rt,
    input [31:0] ImmExt,
    input [4:0] IF_ID_RsAddr,
    input [4:0] IF_ID_RtAddr,
    input [4:0] IF_ID_RdAddr,
    input [3:0] IF_ID_ALUOp,
    input IF_ID_ALUSrc1,
    input IF_ID_ALUSrc2,
    input [1:0] IF_ID_RegDst,
    input IF_ID_MemRd,
    input IF_ID_MemWr,
    input [1:0] IF_ID_MemtoReg,
    input IF_ID_RegWr,
    input [31:0] IF_ID_PC4,
    input [5:0] IF_ID_OpCode,
    output reg [1:0] ID_EX_PCSrc,
    output reg [31:0] ID_EX_Rs,
    output reg [31:0] ID_EX_Rt,
    output reg [31:0] ID_EX_ImmExt,
    output reg [4:0] ID_EX_RsAddr,
    output reg [4:0] ID_EX_RtAddr,
    output reg [4:0] ID_EX_RdAddr,
    output reg [3:0] ID_EX_ALUOp,
    output reg ID_EX_ALUSrc1,
    output reg ID_EX_ALUSrc2,
    output reg [1:0] ID_EX_RegDst,
    output reg ID_EX_MemRd,
    output reg ID_EX_MemWr,
    output reg [1:0] ID_EX_MemtoReg,
    output reg ID_EX_RegWr,
    output reg [31:0] ID_EX_PC4,
    output reg [5:0] ID_EX_OpCode,
);

always @(posedge clk or posedge rst) begin
    if (rst || HzCtrl == 2'b01) begin
        ID_EX_PCSrc <= 2'b00;
        ID_EX_Rs <= 32'h00000000;
        ID_EX_Rt <= 32'h00000000;
        ID_EX_ImmExt <= 32'h00000000;
        ID_EX_RsAddr <= 5'h00;
        ID_EX_RtAddr <= 5'h00;
        ID_EX_RdAddr <= 5'h00;
        ID_EX_ALUOp <= 4'h0;
        ID_EX_ALUSrc1 <= 1'b0;
        ID_EX_ALUSrc2 <= 1'b0;
        ID_EX_RegDst <= 2'b00;
        ID_EX_MemRd <= 1'b0;
        ID_EX_MemWr <= 1'b0;
        ID_EX_MemtoReg <= 2'b00;
        ID_EX_RegWr <= 1'b0;
        ID_EX_PC4 <= 32'h00000000;
        ID_EX_OpCode <= 6'h00;
    end
    else if (HzCtrl == 2'b00) begin
        ID_EX_PCSrc <= PCSrc;
        ID_EX_Rs <= Rs;
        ID_EX_Rt <= Rt;
        ID_EX_ImmExt <= ImmExt;
        ID_EX_RsAddr <= IF_ID_RsAddr;
        ID_EX_RtAddr <= IF_ID_RtAddr;
        ID_EX_RdAddr <= IF_ID_RdAddr;
        ID_EX_ALUOp <= IF_ID_ALUOp;
        ID_EX_ALUSrc1 <= IF_ID_ALUSrc1;
        ID_EX_ALUSrc2 <= IF_ID_ALUSrc2;
        ID_EX_RegDst <= IF_ID_RegDst;
        ID_EX_MemRd <= IF_ID_MemRd;
        ID_EX_MemWr <= IF_ID_MemWr;
        ID_EX_MemtoReg <= IF_ID_MemtoReg;
        ID_EX_RegWr <= IF_ID_RegWr;
        ID_EX_PC4 <= IF_ID_PC4;
        ID_EX_OpCode <= IF_ID_OpCode;
    end
end

endmodule