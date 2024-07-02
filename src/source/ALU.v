`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/01 19:14:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: ALU
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2017.4
// Description: Arithmetic Logic Unit
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU (
	input [31:0] ALUIn1, 
	input [31:0] ALUIn2,
	input [4:0] ALUCtrl,
	input Sign,
	output reg [31:0] ALUOut
);
	
	wire lt_signed;
	assign lt_signed = (ALUIn1[31] ^ ALUIn2[31]) ? (({ALUIn1[31], ALUIn2[31]} == 2'b01) ? 0 : 1) : (ALUIn1[30:0] < ALUIn2[30:0]);
	

	always @(*) begin
		case (ALUCtrl)
			5'b00000: ALUOut <= ALUIn1 & ALUIn2;
			5'b00001: ALUOut <= ALUIn1 | ALUIn2;
			5'b00010: ALUOut <= ALUIn1 + ALUIn2;
			5'b00110: ALUOut <= ALUIn1 - ALUIn2;
			5'b00111: ALUOut <= {31'h00000000, Sign ? lt_signed : (ALUIn1 < ALUIn2)};
			5'b01100: ALUOut <= ~(ALUIn1 | ALUIn2);
			5'b01101: ALUOut <= ALUIn1 ^ ALUIn2;
			5'b10000: ALUOut <= (ALUIn2 << ALUIn1[4:0]);
			5'b11000: ALUOut <= (ALUIn2 >> ALUIn1[4:0]);
			5'b11001: ALUOut <= ({{32{ALUIn2[31]}}, ALUIn2} >> ALUIn1[4:0]);
			5'b11010: ALUOut <= ALUIn1 * ALUIn2;
			default: ALUOut <= 32'h00000000;
		endcase
	end

endmodule