`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/01 21:41:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: MEM_WB
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2017.4
// Description: MEM/WB Register
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module MEM_WB (
    input rst,
    input clk,
    input [31:0] MemRdData,
    input [31:0] EX_MEM_ALUOut,
    input [4:0] EX_MEM_RegWrAddr,
    input [1:0] EX_MEM_MemtoReg,
    input EX_MEM_RegWr,
    input [31:0] EX_MEM_PC4,
    output reg [31:0] MEM_WB_MemRdData,
    output reg [31:0] MEM_WB_ALUOut,
    output reg [4:0] MEM_WB_RegWrAddr,
    output reg [1:0] MEM_WB_MemtoReg,
    output reg MEM_WB_RegWr,
    output reg [31:0] MEM_WB_PC4
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        MEM_WB_MemRdData <= 32'h00000000;
        MEM_WB_ALUOut <= 32'h00000000;
        MEM_WB_RegWrAddr <= 5'h00;
        MEM_WB_MemtoReg <= 2'b00;
        MEM_WB_RegWr <= 1'b0;
        MEM_WB_PC4 <= 32'h00000000;
    end
    else begin
        MEM_WB_MemRdData <= MemRdData;
        MEM_WB_ALUOut <= EX_MEM_ALUOut;
        MEM_WB_RegWrAddr <= EX_MEM_RegWrAddr;
        MEM_WB_MemtoReg <= EX_MEM_MemtoReg;
        MEM_WB_RegWr <= EX_MEM_RegWr;
        MEM_WB_PC4 <= EX_MEM_PC4;
    end
end

endmodule