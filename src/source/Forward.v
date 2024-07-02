`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/02 11:44:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: EX_Forward, MEM_Forward
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2018.3
// Description: EX Forwarding Unit, MEM Forwarding Unit
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module EX_Forward (
    input [4:0] ID_EX_RsAddr,
    input [4:0] ID_EX_RtAddr,
    input [4:0] EX_MEM_RegWrAddr,
    input EX_MEM_RegWr,
    input [4:0] MEM_WB_RegWrAddr,
    input MEM_WB_RegWr,
    output wire [1:0] EX_ForwardRs,
    output wire [1:0] EX_ForwardRt,
);

assign EX_ForwardRs = 
                (EX_MEM_RegWr && EX_MEM_RegWrAddr != 0 && EX_MEM_RegWrAddr == ID_EX_RsAddr) ? 2'b01 :
                (MEM_WB_RegWr && MEM_WB_RegWrAddr != 0 && MEM_WB_RegWrAddr == ID_EX_RsAddr) ? 2'b10 :
                2'b00;
assign EX_ForwardRt = 
                (EX_MEM_RegWr && EX_MEM_RegWrAddr != 0 && EX_MEM_RegWrAddr == ID_EX_RtAddr) ? 2'b01 :
                (MEM_WB_RegWr && MEM_WB_RegWrAddr != 0 && MEM_WB_RegWrAddr == ID_EX_RtAddr) ? 2'b10 :
                2'b00;

endmodule



module MEM_Forward (
    input [4:0] EX_MEM_RtAddr,
    input [4:0] MEM_WB_RegWrAddr,
    input MEM_WB_RegWr,
    output wire MEM_ForwardRt,
);

assign MEM_ForwardRt = 
                (MEM_WB_RegWr && MEM_WB_RegWrAddr != 0 && MEM_WB_RegWrAddr == EX_MEM_RtAddr) ? 1'b1 :
                1'b0;

endmodule