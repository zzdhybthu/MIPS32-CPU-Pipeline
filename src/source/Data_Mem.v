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
	
	parameter RAM_SIZE = 256;  // 0x00000000 ~ 0x000007FF
	
	reg [31:0] RAM_data [RAM_SIZE - 1 : 0];
	reg [31:0] Digit;

	wire [29:0] Addr_word;
	assign Addr_word = Addr[31:2];

	assign RdData = !MemRd ? 32'h00000000 :
					   Addr_word < RAM_SIZE ? RAM_data[Addr_word] :
					   Addr_word == 30'h40000010 ? Digit :
					   32'h00000000;
		
	
	integer i;

	initial begin
		for (i = 0; i < RAM_SIZE; i = i + 1) begin
			RAM_data[i] <= 32'h00000000;
		end
		Digit <= 32'h00000000;
	end

	always @(posedge rst or posedge clk) begin
		if (rst) begin
            RAM_data[0] <= 32'hffffffd3; // X0 = -45
            RAM_data[1] <= 32'h00000003; // Y0 = 3
            RAM_data[2] <= 32'h00000028; // X1 = 40
            RAM_data[3] <= 32'h00000024; // Y1 = 36
            RAM_data[4] <= 32'hfffffffe; // X2 = -2
            RAM_data[5] <= 32'h00000006; // Y2 = 6
            RAM_data[6] <= 32'hfffffff9; // X3 = -7
            RAM_data[7] <= 32'h0000003a; // Y3 = 58
            
            for (i = 8; i < RAM_SIZE; i = i + 1)
                RAM_data[i] <= 32'h00000000;
//            for (i = 0; i < RAM_SIZE; i = i + 1) begin
//                RAM_data[i] <= 32'h00000000;
//			end
			Digit <= 32'h00000000;
		end
		else if (MemWr) begin
			RAM_data[Addr[9:2]] <= WrData;
		end
	end
			
endmodule
