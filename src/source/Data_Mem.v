`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/01 20:07:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: Data_Mem
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2017.4
// Description: Data Memory, RAM
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module Data_Mem (
	input  rst, 
	input  clk,  
	input  MemRd,
	input  MemWr,
	input  [31:0] Addr,
	input  [31:0] WrData,
	output [31:0] RdData
);
	
	parameter RAM_SIZE = 512;  // 0x00000000 ~ 0x000007FF
	parameter RAM_ADDR_WIDTH = 9;  // 2^9 = 512
	
	reg [31:0] RAM_data [RAM_SIZE - 1 : 0];
	reg [31:0] Digit;

	wire [RAM_ADDR_WIDTH - 1 : 0] Addr_word;
	assign Addr_word = Addr[RAM_ADDR_WIDTH + 1 : 2];

	assign RdData = !MemRd ? 32'h00000000 :
					   Addr_word < RAM_SIZE ? RAM_data[Addr_word] :
					   Addr_word == 30'h40000010 ? Digit :
					   32'h00000000;
	
	
	integer i;

	initial begin

            // // single cycle processor test case 2

            // RAM_data[0] <= 32'hffffffd3; // X0 = -45
            // RAM_data[1] <= 32'h00000003; // Y0 = 3
            // RAM_data[2] <= 32'h00000028; // X1 = 40
            // RAM_data[3] <= 32'h00000024; // Y1 = 36
            // RAM_data[4] <= 32'hfffffffe; // X2 = -2
            // RAM_data[5] <= 32'h00000006; // Y2 = 6
            // RAM_data[6] <= 32'hfffffff9; // X3 = -7
            // RAM_data[7] <= 32'h0000003a; // Y3 = 58
            
            // for (i = 8; i < RAM_SIZE; i = i + 1)
            //     RAM_data[i] <= 32'h00000000;



			// insert sort and binary insert sort test case
			
			RAM_data[0] <= 32'h00000014;
			RAM_data[1] <= 32'h000041a8;
			RAM_data[2] <= 32'h00003af2;
			RAM_data[3] <= 32'h0000acda;
			RAM_data[4] <= 32'h00000c2b;
			RAM_data[5] <= 32'h0000b783;
			RAM_data[6] <= 32'h0000dac9;
			RAM_data[7] <= 32'h00008ed9;
			RAM_data[8] <= 32'h000009ff;
			RAM_data[9] <= 32'h00002f44;
			RAM_data[10] <= 32'h0000044e;
			RAM_data[11] <= 32'h00009899;
			RAM_data[12] <= 32'h00003c56;
			RAM_data[13] <= 32'h0000128d;
			RAM_data[14] <= 32'h0000dbe3;
			RAM_data[15] <= 32'h0000d4b4;
			RAM_data[16] <= 32'h00003748;
			RAM_data[17] <= 32'h00003918;
			RAM_data[18] <= 32'h00004112;
			RAM_data[19] <= 32'h0000c399;
			RAM_data[20] <= 32'h00004955;

			for (i = 21; i < RAM_SIZE; i = i + 1)
				RAM_data[i] <= 32'h00000000;



			// // original test case
			
            // for (i = 0; i < RAM_SIZE; i = i + 1) begin
            //    RAM_data[i] <= 32'h00000000;
			// end


			Digit <= 32'h00000000;

	end


	always @(posedge rst or posedge clk) begin
		if (rst) begin
            for (i = 0; i < RAM_SIZE; i = i + 1) begin
               RAM_data[i] <= 32'h00000000;
			end
			Digit <= 32'h00000000;
		end
		else if (MemWr) begin
			RAM_data[Addr_word] <= WrData;
		end
	end
			
endmodule
