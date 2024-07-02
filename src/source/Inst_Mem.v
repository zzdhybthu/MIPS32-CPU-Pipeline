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
// Tool Versions: Vivado 2017.4
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
	output reg [31:0] Inst
);
	
	always @(*)
		case (Addr[9:2])
        
//            8'd0:	Inst <= 32'h20042f5b;
//            8'd1:	Inst <= 32'h2405cfc7;
//            8'd2:	Inst <= 32'h00053400;
//            8'd3:	Inst <= 32'h00063c03;
//            8'd4:	Inst <= 32'hac040000;
//            8'd5:	Inst <= 32'h10e50001;
//            8'd6:	Inst <= 32'h3c0456ce;
//            8'd7:	Inst <= 32'h00c44020;
//            8'd8:	Inst <= 32'h00084a03;
//            8'd9:	Inst <= 32'h200ad0a5;
//            8'd10:	Inst <= 32'h008a102a;
//            8'd11:	Inst <= 32'h008a182b;
//            8'd12:	Inst <= 32'h8c0b0000;
//            8'd13:	Inst <= 32'h0810000d;

			// 8'd0:	Inst<= 32'h20040000;
            // 8'd1:	Inst<= 32'h20050020;
            // 8'd2:	Inst<= 32'h20100000;
            // 8'd3:	Inst<= 32'h8c880000;
            // 8'd4:	Inst<= 32'h8c890004;
            // 8'd5:	Inst<= 32'h71095002;
            // 8'd6:	Inst<= 32'h020a8020;
            // 8'd7:	Inst<= 32'h20840008;
            // 8'd8:	Inst<= 32'h10850001;
            // 8'd9:	Inst<= 32'h08100003;
            // 8'd10:	Inst<= 32'hacb00000;
            // 8'd11:	Inst<= 32'h0810000b;
            
			default: Inst <= 32'h00000000;
		endcase
		
endmodule
