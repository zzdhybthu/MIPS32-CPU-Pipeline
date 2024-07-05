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
    output reg [31:0] PC,
    output wire [31:0] PC4
);

initial begin
    PC <= 32'h00400000;
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        PC <= 32'h00400000;
    end
    else begin
        if (!Keep) begin
            PC <= PC_Next;
        end
    end
end

assign PC4 = PC + 32'h00000004;

endmodule