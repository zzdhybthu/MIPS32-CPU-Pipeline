`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/02 18:10:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: Test_CPU
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2017.4
// Description: Test CPU
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module Test_CPU (

);
reg clk, rst;

CPU cpu (
    .clk(clk),
    .rst(rst)
);

initial begin
    clk = 1'b0;
    rst = 1'b1;
    #100 rst = 1'b0;
end

always #50 clk = ~clk;


endmodule