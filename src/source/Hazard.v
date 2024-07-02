`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/02 14:57:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: Ld_Use_Hazard
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2018.3
// Description: Load-Use Hazard Detection
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module Ld_Use_Hazard (
    input ID_EX_MemRd,
    input [4:0] ID_EX_RtAddr,
    input [4:0] IF_ID_RsAddr,
    input [4:0] IF_ID_RtAddr,
    output wire LdUseHazard,
);

assign LdUseHazard = 
                (ID_EX_MemRd && (ID_EX_RtAddr == IF_ID_RsAddr || ID_EX_RtAddr == IF_ID_RtAddr)) ? 1'b1 :
                1'b0;

endmodule

