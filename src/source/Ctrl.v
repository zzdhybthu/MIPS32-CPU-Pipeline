`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/01 21:59:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: Ctrl
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2017.4
// Description: Control Unit
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module Ctrl(
	input [5:0] OpCode,
	input [5:0] Funct,
	output wire [1:0] PCSrc,
	output wire RegWr,
	output wire [1:0] RegDst,
	output wire MemRd,
	output wire MemWr,
	output wire [1:0] MemtoReg,
	output wire ALUSrc1,
	output wire ALUSrc2,
	output wire ExtOp,
	output wire LuOp,
	output wire [3:0] ALUOp
);

	assign PCSrc =
		(OpCode == 6'h02 || OpCode == 6'h03) ? 2'b01:  // j, jal
		(OpCode == 6'h00 && (Funct == 6'h08 || Funct == 6'h09)) ? 2'b10:  // jr, jalr
		2'b00;  // others

	assign RegWr = 
		(OpCode == 6'h2b || OpCode == 6'h01 || OpCode == 6'h02 || 
		(OpCode >= 6'h04 && OpCode <= 6'h07) || 
		(OpCode == 6'h00 && Funct == 6'h08)) ? 1'b0:
		1'b1;
	
	assign RegDst =
		(OpCode == 6'h00 || OpCode == 6'h1c) ? 2'b01: // R-type or mul, use Rd
		(OpCode == 6'h03) ? 2'b10: // JAL, use 31
		2'b00; // I-type, use Rt

	assign MemRd = 
		(OpCode == 6'h23) ? 1'b1:  // lw
		1'b0;  // others
	
	assign MemWr = 
		(OpCode == 6'h2b) ? 1'b1:  // sw
		1'b0;  // others
	
	assign MemtoReg = 
		(OpCode == 6'h23) ? 2'b01:  // lw, use MemOut
		(OpCode == 6'h03 || (OpCode == 6'h00 && Funct == 6'h09)) ? 2'b10:  // jal, jalr, use PC + 4
		2'b00;  // others, use ALUOut

	assign ALUSrc1 = 
		(OpCode == 6'h00 && (Funct == 6'h00 || Funct == 6'h02 || Funct == 6'h03)) ? 1'b1:  // sll, srl, sra, use shamt
		1'b0;  // others, use Rs
	
	assign ALUSrc2 = 
		(OpCode == 6'h00 || OpCode == 6'h1c) ? 1'b0:  // R-type, mul, use Rt
		1'b1;  // others, use ImmExt

	assign ExtOp = 
		(OpCode == 6'h0f || OpCode == 6'h0c) ? 1'b0:  // lui, andi, use zero extend
		1'b1;  // others, use sign extend
	
	assign LuOp = 
		(OpCode == 6'h0f) ? 1'b1:  // lui
		1'b0;  // others

	assign ALUOp[2:0] = 
		(OpCode == 6'h00) ? 3'b010:  // R-type
		(OpCode == 6'h0c) ? 3'b100:  // andi
		(OpCode == 6'h1c) ? 3'b110:  // mul
		(OpCode == 6'h0a || OpCode == 6'h0b) ? 3'b101:  // slti, sltiu
		3'b000;  // others
	
	assign ALUOp[3] = OpCode[0];
	
endmodule