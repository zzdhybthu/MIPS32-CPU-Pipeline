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
	output wire [31:0] RdData,
	output reg [11:0] RAM_Digi
);
	
	parameter RAM_SIZE = 512;  // 0x00000000 ~ 0x000007FF
	parameter RAM_ADDR_WIDTH = 9;  // 2^9 = 512
	
	reg [31:0] RAM_Data [RAM_SIZE - 1 : 0];

	wire [RAM_ADDR_WIDTH - 1 : 0] AddrWord;
	assign AddrWord = Addr[RAM_ADDR_WIDTH + 1 : 2];


	// read data from RAM
	assign RdData = (MemRd && AddrWord < RAM_SIZE) ? RAM_Data[AddrWord] : 32'h00000000;
	
	
	integer i;

	initial begin

		RAM_Digi <= 12'h0;

		// // single cycle processor test case 2

		// RAM_Data[0] <= 32'hffffffd3; // X0 = -45
		// RAM_Data[1] <= 32'h00000003; // Y0 = 3
		// RAM_Data[2] <= 32'h00000028; // X1 = 40
		// RAM_Data[3] <= 32'h00000024; // Y1 = 36
		// RAM_Data[4] <= 32'hfffffffe; // X2 = -2
		// RAM_Data[5] <= 32'h00000006; // Y2 = 6
		// RAM_Data[6] <= 32'hfffffff9; // X3 = -7
		// RAM_Data[7] <= 32'h0000003a; // Y3 = 58
		
		// for (i = 8; i < RAM_SIZE; i = i + 1)
		//     RAM_Data[i] <= 32'h00000000;

			// insert sort and binary insert sort test case

			RAM_Data[0] <= 32'h00000014;
			RAM_Data[1] <= 32'h000041a8;
			RAM_Data[2] <= 32'h00003af2;
			RAM_Data[3] <= 32'h0000acda;
			RAM_Data[4] <= 32'h00000c2b;
			RAM_Data[5] <= 32'h0000b783;
			RAM_Data[6] <= 32'h0000dac9;
			RAM_Data[7] <= 32'h00008ed9;
			RAM_Data[8] <= 32'h000009ff;
			RAM_Data[9] <= 32'h00002f44;
			RAM_Data[10] <= 32'h0000044e;
			RAM_Data[11] <= 32'h00009899;
			RAM_Data[12] <= 32'h00003c56;
			RAM_Data[13] <= 32'h0000128d;
			RAM_Data[14] <= 32'h0000dbe3;
			RAM_Data[15] <= 32'h0000d4b4;
			RAM_Data[16] <= 32'h00003748;
			RAM_Data[17] <= 32'h00003918;
			RAM_Data[18] <= 32'h00004112;
			RAM_Data[19] <= 32'h0000c399;
			RAM_Data[20] <= 32'h00004955;
			
			for (i = 21; i < RAM_SIZE; i = i + 1)
				RAM_Data[i] <= 32'h00000000;
				
//		// original test case
		
//		for (i = 0; i < RAM_SIZE; i = i + 1) begin
//		   RAM_Data[i] <= 32'h00000000;
//		end

	end


	always @(posedge clk or posedge rst) begin
		if (rst) begin
		RAM_Digi <= 12'h0;

        // // single cycle processor test case 2

        // RAM_Data[0] <= 32'hffffffd3; // X0 = -45
        // RAM_Data[1] <= 32'h00000003; // Y0 = 3
        // RAM_Data[2] <= 32'h00000028; // X1 = 40
        // RAM_Data[3] <= 32'h00000024; // Y1 = 36
        // RAM_Data[4] <= 32'hfffffffe; // X2 = -2
        // RAM_Data[5] <= 32'h00000006; // Y2 = 6
        // RAM_Data[6] <= 32'hfffffff9; // X3 = -7
        // RAM_Data[7] <= 32'h0000003a; // Y3 = 58
        
        // for (i = 8; i < RAM_SIZE; i = i + 1)
        //     RAM_Data[i] <= 32'h00000000;

            // insert sort and binary insert sort test case

            RAM_Data[0] <= 32'h00000014;
            RAM_Data[1] <= 32'h000041a8;
            RAM_Data[2] <= 32'h00003af2;
            RAM_Data[3] <= 32'h0000acda;
            RAM_Data[4] <= 32'h00000c2b;
            RAM_Data[5] <= 32'h0000b783;
            RAM_Data[6] <= 32'h0000dac9;
            RAM_Data[7] <= 32'h00008ed9;
            RAM_Data[8] <= 32'h000009ff;
            RAM_Data[9] <= 32'h00002f44;
            RAM_Data[10] <= 32'h0000044e;
            RAM_Data[11] <= 32'h00009899;
            RAM_Data[12] <= 32'h00003c56;
            RAM_Data[13] <= 32'h0000128d;
            RAM_Data[14] <= 32'h0000dbe3;
            RAM_Data[15] <= 32'h0000d4b4;
            RAM_Data[16] <= 32'h00003748;
            RAM_Data[17] <= 32'h00003918;
            RAM_Data[18] <= 32'h00004112;
            RAM_Data[19] <= 32'h0000c399;
            RAM_Data[20] <= 32'h00004955;
            
            for (i = 21; i < RAM_SIZE; i = i + 1)
                RAM_Data[i] <= 32'h00000000;
                
//        // original test case
        
//        for (i = 0; i < RAM_SIZE; i = i + 1) begin
//           RAM_Data[i] <= 32'h00000000;
//        end

		end
		// write data to RAM
		else if (MemWr) begin
			if (Addr == 32'h40000010)
				RAM_Digi <= WrData[11:0];
			else if (AddrWord < RAM_SIZE)
				RAM_Data[AddrWord] <= WrData;
		end
	end
			
endmodule
