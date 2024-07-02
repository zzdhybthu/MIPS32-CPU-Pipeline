`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/02 12:20:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: PC
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2017.4
// Description: PC Register
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module PC (
    input rst,
    input clk,
    input Keep,
    input [31:0] PC_Next,
    output wire [31:0] PC,
    output wire [31:0] PC4
);

reg [31:0] PC_Reg;

initial begin
    PC_Reg <= 32'h00400000;
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        PC_Reg <= 32'h00400000;
    end
    else if (!Keep) begin
        PC_Reg <= PC_Next;
    end
end

assign PC = PC_Reg;
assign PC4 = PC_Reg + 32'h00000004;

endmodule