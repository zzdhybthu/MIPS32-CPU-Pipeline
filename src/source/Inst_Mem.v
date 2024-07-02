`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/01 20:00:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: Inst_Mem
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2018.3
// Description: Instruction Memory, ROM
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module Inst_Mem (
	input [31:0] Addr, 
	output reg [31:0] Inst,
);
	
	always @(*)
		case (Addr[9:2])

            8'd00: Inst <= 32'h8c080000;
            8'd01: Inst <= 32'h8c090004;
            8'd02: Inst <= 32'h8c0a0008;
            8'd03: Inst <= 32'h8c0b000c;
            8'd04: Inst <= 32'h8c0c0010;
            8'd05: Inst <= 32'h8c0d0014;
            8'd06: Inst <= 32'h8c0e0018;
            8'd07: Inst <= 32'h8c0f001c;
            8'd08: Inst <= 32'h010c802d;
            8'd09: Inst <= 32'h012d202d;
            8'd10: Inst <= 32'h02048020;
            8'd11: Inst <= 32'h010e882d;
            8'd12: Inst <= 32'h012f202d;
            8'd13: Inst <= 32'h02248820;
            8'd14: Inst <= 32'h0200882e;
            8'd15: Inst <= 32'h014c902d;
            8'd16: Inst <= 32'h016d202d;
            8'd17: Inst <= 32'h02449020;
            8'd18: Inst <= 32'h014e982d;
            8'd19: Inst <= 32'h016f202d;
            8'd20: Inst <= 32'h02649820;
            8'd21: Inst <= 32'h0240982e;
            8'd22: Inst <= 32'hac100020;
            8'd23: Inst <= 32'hac110024;
            8'd24: Inst <= 32'hac120028;
            8'd25: Inst <= 32'hac13002c;
            8'd26: Inst <= 32'h0810001a;
			// -------- Paste Binary Inst Above
			
			default: Inst <= 32'h00000000;
		endcase
		
endmodule
