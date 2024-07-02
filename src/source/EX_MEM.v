`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/01 21:27:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: EX_MEM
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2017.4
// Description: EX/MEM Register
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module EX_MEM (
    input rst,
    input clk,
    input [4:0] RegWrAddr,
    input [31:0] ALUOut,
    input [4:0] ID_EX_RtAddr,
    input [31:0] ID_EX_Rt,
    input ID_EX_MemRd,
    input ID_EX_MemWr,
    input [1:0] ID_EX_MemtoReg,
    input ID_EX_RegWr,
    input [31:0] ID_EX_PC4,
    output reg [4:0] EX_MEM_RegWrAddr,
    output reg [31:0] EX_MEM_ALUOut,
    output reg [4:0] EX_MEM_RtAddr,
    output reg [31:0] EX_MEM_Rt,
    output reg EX_MEM_MemRd,
    output reg EX_MEM_MemWr,
    output reg [1:0] EX_MEM_MemtoReg,
    output reg EX_MEM_RegWr,
    output reg [31:0] EX_MEM_PC4
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        EX_MEM_RegWrAddr <= 5'h00;
        EX_MEM_ALUOut <= 32'h00000000;
        EX_MEM_RtAddr <= 5'h00;
        EX_MEM_Rt <= 32'h00000000;
        EX_MEM_MemRd <= 1'b0;
        EX_MEM_MemWr <= 1'b0;
        EX_MEM_MemtoReg <= 2'b00;
        EX_MEM_RegWr <= 1'b0;
        EX_MEM_PC4 <= 32'h00000000;
    end
    else begin
        EX_MEM_RegWrAddr <= RegWrAddr;
        EX_MEM_ALUOut <= ALUOut;
        EX_MEM_RtAddr <= ID_EX_RtAddr;
        EX_MEM_Rt <= ID_EX_Rt;
        EX_MEM_MemRd <= ID_EX_MemRd;
        EX_MEM_MemWr <= ID_EX_MemWr;
        EX_MEM_MemtoReg <= ID_EX_MemtoReg;
        EX_MEM_RegWr <= ID_EX_RegWr;
        EX_MEM_PC4 <= ID_EX_PC4;
    end
end

endmodule