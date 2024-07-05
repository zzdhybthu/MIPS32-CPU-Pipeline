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
// Tool Versions: Vivado 2017.4
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
    input [3:0] ALUOp,
    input ALUSrc1,
    input ALUSrc2,
    input Sign,
    input LuOp,
    input [1:0] RegDst,
    input MemRd,
    input MemWr,
    input [1:0] MemtoReg,
    input RegWr,
    input [31:0] IF_ID_PC4,
    input [5:0] IF_ID_OpCode,
    input [4:0] ALUCtrl,
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
    output reg ID_EX_Sign,
    output reg ID_EX_LuOp,
    output reg [1:0] ID_EX_RegDst,
    output reg ID_EX_MemRd,
    output reg ID_EX_MemWr,
    output reg [1:0] ID_EX_MemtoReg,
    output reg ID_EX_RegWr,
    output reg [31:0] ID_EX_PC4,
    output reg [5:0] ID_EX_OpCode,
    output reg [4:0] ID_EX_ALUCtrl
);

initial  begin
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
        ID_EX_Sign <= 1'b0;
        ID_EX_LuOp <= 1'b0;
        ID_EX_RegDst <= 2'b00;
        ID_EX_MemRd <= 1'b0;
        ID_EX_MemWr <= 1'b0;
        ID_EX_MemtoReg <= 2'b00;
        ID_EX_RegWr <= 1'b0;
        ID_EX_PC4 <= 32'h00000000;
        ID_EX_OpCode <= 6'h00;
        ID_EX_ALUCtrl <= 5'h00;
    end

always @(posedge clk or posedge rst) begin
    if (rst) begin
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
        ID_EX_Sign <= 1'b0;
        ID_EX_LuOp <= 1'b0;
        ID_EX_RegDst <= 2'b00;
        ID_EX_MemRd <= 1'b0;
        ID_EX_MemWr <= 1'b0;
        ID_EX_MemtoReg <= 2'b00;
        ID_EX_RegWr <= 1'b0;
        ID_EX_PC4 <= 32'h00000000;
        ID_EX_OpCode <= 6'h00;
        ID_EX_ALUCtrl <= 5'h00;
    end
    else begin
        if (HzCtrl == 2'b01) begin
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
            ID_EX_Sign <= 1'b0;
            ID_EX_LuOp <= 1'b0;
            ID_EX_RegDst <= 2'b00;
            ID_EX_MemRd <= 1'b0;
            ID_EX_MemWr <= 1'b0;
            ID_EX_MemtoReg <= 2'b00;
            ID_EX_RegWr <= 1'b0;
            ID_EX_PC4 <= 32'h00000000;
            ID_EX_OpCode <= 6'h00;
            ID_EX_ALUCtrl <= 5'h00;
        end
        else if (HzCtrl == 2'b00) begin
            ID_EX_PCSrc <= PCSrc;
            ID_EX_Rs <= Rs;
            ID_EX_Rt <= Rt;
            ID_EX_ImmExt <= ImmExt;
            ID_EX_RsAddr <= IF_ID_RsAddr;
            ID_EX_RtAddr <= IF_ID_RtAddr;
            ID_EX_RdAddr <= IF_ID_RdAddr;
            ID_EX_ALUOp <= ALUOp;
            ID_EX_ALUSrc1 <= ALUSrc1;
            ID_EX_ALUSrc2 <= ALUSrc2;
            ID_EX_Sign <= Sign;
            ID_EX_LuOp <= LuOp;
            ID_EX_RegDst <= RegDst;
            ID_EX_MemRd <= MemRd;
            ID_EX_MemWr <= MemWr;
            ID_EX_MemtoReg <= MemtoReg;
            ID_EX_RegWr <= RegWr;
            ID_EX_PC4 <= IF_ID_PC4;
            ID_EX_OpCode <= IF_ID_OpCode;
            ID_EX_ALUCtrl <= ALUCtrl;
        end
    end
end

endmodule