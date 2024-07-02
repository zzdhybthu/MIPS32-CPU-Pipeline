`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/01 21:59:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: RF
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2018.3
// Description: Register File
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module RF (
	input rst,
	input clk,
	input [4:0] RsAddr,
	input [4:0] RtAddr,
	input [4:0] WrAddr,
	input [31:0] WrData,
	input RegWr,
	output wire [31:0] RdData1,
	output wire [31:0] RdData2,
);

reg [31:0] RF_data [31:1];

assign RdData1 = RsAddr == 0 ? 32'h00000000 :
				 RegWr && WrAddr == RsAddr ? WrData :
				 RF_data[RsAddr];
assign RdData2 = RtAddr == 0 ? 32'h00000000 :
				 RegWr && WrAddr == RtAddr ? WrData :
				 RF_data[RtAddr];

initial i;
initial begin
	for (i = 1; i < 32; i = i + 1) begin
		RF_data[i] = 32'h00000000;
	end
end

always @(posedge rst or posedge clk) begin
	if (rst) begin
		for (i = 1; i < 32; i = i + 1) begin
			RF_data[i] = 32'h00000000;
		end
	end
	else begin
		if (RegWr && WrAddr != 0) begin
			RF_data[WrAddr] = WrData;
		end
	end
end

endmodule
