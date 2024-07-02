`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/01 19:14:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: ALU_Ctrl
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2017.4
// Description: ALU Control Unit
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU_Ctrl (
	input [3:0] ALUOp,
	input [5:0] Funct,
	output reg [4:0] ALUCtrl,
	output wire Sign
);
	
	parameter aluAND = 5'b00000;
	parameter aluOR  = 5'b00001;
	parameter aluADD = 5'b00010;
	parameter aluSUB = 5'b00110;
	parameter aluSLT = 5'b00111;
	parameter aluNOR = 5'b01100;
	parameter aluXOR = 5'b01101;
	parameter aluSLL = 5'b10000;
	parameter aluSRL = 5'b11000;
	parameter aluSRA = 5'b11001;
	parameter aluMUL = 5'b11010;
	
	assign Sign = (ALUOp[2:0] == 3'b010) ? ~Funct[0] : ~ALUOp[3];
	
	reg [4:0] aluFunct;
	always @(*)
		casez (Funct)
			6'b00_0000: aluFunct <= aluSLL;
			6'b00_0010: aluFunct <= aluSRL;
			6'b00_0011: aluFunct <= aluSRA;
			6'b10_001?: aluFunct <= aluSUB;
			6'b10_0100: aluFunct <= aluAND;
			6'b10_0101: aluFunct <= aluOR;
			6'b10_0110: aluFunct <= aluXOR;
			6'b10_0111: aluFunct <= aluNOR;
			6'b10_101?: aluFunct <= aluSLT;
			default: aluFunct <= aluADD;
		endcase
	
	always @(*)
		case (ALUOp[2:0])
			3'b001: ALUCtrl <= aluSUB;
			3'b100: ALUCtrl <= aluAND;
			3'b101: ALUCtrl <= aluSLT;
			3'b010: ALUCtrl <= aluFunct;
			3'b110: ALUCtrl <= aluMUL;
			default: ALUCtrl <= aluADD;
		endcase

endmodule
