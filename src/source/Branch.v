`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/02 16:05:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: Branch
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2018.3
// Description: Branch Control
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module Branch (
    input OpCode,
    input [31:0] RsData,
    input [31:0] RtData,
    output wire Branch,
);

assign Branch = 
            (OpCode == 6'h04 && RsData == RtData) ? 1'b1:
            (OpCode == 6'h05 && RsData != RtData) ? 1'b1:
            (OpCode == 6'h06 && RsData <= 32'd0) ? 1'b1:
            (OpCode == 6'h07 && RsData > 32'd0) ? 1'b1:
            (OpCode == 6'h01 && RsData < 32'd0) ? 1'b1:
            1'b0;

endmodule