`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/03 14:25:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: Clock
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2017.4
// Description: Clock Module
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module Clock(
    input rst,
    input clk,
    output reg ClockNew
);

    parameter CNT = 16'd5;

    reg [15:0] Count;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            ClockNew <= 1'b0;
            Count <= 16'b0;
        end
        else begin
            Count <= (Count == CNT - 16'b1) ? 16'b0 : Count + 16'b1;
            ClockNew <= (Count == 16'b0) ? ~ClockNew : ClockNew;
        end
    end

endmodule