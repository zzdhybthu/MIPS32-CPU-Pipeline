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
    input RxSerial,
	output wire [31:0] RdData,
	output reg [11:0] RAM_Digi,
    output wire TxSerial
);
	
	parameter RAM_SIZE = 512;  // 0x00000000 ~ 0x000007FC
	parameter RAM_ADDR_WIDTH = 9;  // 2^9 = 512
    parameter CLKS_PER_BIT = 7813;  // 75MHz / 9600bps = 7812.5
	
	reg [31:0] RAM_Data [RAM_SIZE - 1 : 0];

	wire [RAM_ADDR_WIDTH - 1 : 0] AddrWord;
	assign AddrWord = Addr[RAM_ADDR_WIDTH + 1 : 2];

    
    // UART
    wire RxValid;
    wire [7:0] RxRd;
    reg [7:0] RxData;
    reg [7:0] RxByte;
    UART_RX #(CLKS_PER_BIT) uart_rx (
        .clk(clk),
        .i_Rx_Serial(RxSerial),
        .o_Rx_Byte(RxRd),
        .o_Rx_DV(RxValid)
    );

    reg [7:0] TxByte;
    reg TxValid;
    wire TxActive, TxDone;
    UART_TX #(CLKS_PER_BIT) uart_tx (
        .clk(clk),
        .i_Tx_Byte(TxByte),
        .i_Tx_DV(TxValid),
        .o_Tx_Serial(TxSerial),
        .o_Tx_Active(TxActive),
        .o_Tx_Done(TxDone)
    );

    reg [2:0] UART_Ctrl;  // 0: TxDone, 1: RxDone, 2: TxActive


	// read data from RAM
	assign RdData = 
                MemRd ? (
                    Addr == 32'h4000001C ? {24'h0, RxByte} :
                    Addr == 32'h40000020 ? {27'h0, UART_Ctrl, 2'b0} :
                    Addr == 32'h40000018 ? 32'h00000000 :
                    RAM_Data[AddrWord]
                    ) :
                32'h00000000;
	
	
    // initial RAM
	integer i;
	initial begin

        RAM_Digi <= 12'h0;
        TxByte <= 8'h0;
        TxValid <= 1'b0;
        UART_Ctrl <= 3'b000;


		// // used for sort method and led display simulation only

		// RAM_Data[0] <= 32'h00000014;
		// RAM_Data[1] <= 32'h000041a8;
		// RAM_Data[2] <= 32'h00003af2;
		// RAM_Data[3] <= 32'h0000acda;
		// RAM_Data[4] <= 32'h00000c2b;
		// RAM_Data[5] <= 32'h0000b783;
		// RAM_Data[6] <= 32'h0000dac9;
		// RAM_Data[7] <= 32'h00008ed9;
		// RAM_Data[8] <= 32'h000009ff;
		// RAM_Data[9] <= 32'h00002f44;
		// RAM_Data[10] <= 32'h0000044e;
		// RAM_Data[11] <= 32'h00009899;
		// RAM_Data[12] <= 32'h00003c56;
		// RAM_Data[13] <= 32'h0000128d;
		// RAM_Data[14] <= 32'h0000dbe3;
		// RAM_Data[15] <= 32'h0000d4b4;
		// RAM_Data[16] <= 32'h00003748;
		// RAM_Data[17] <= 32'h00003918;
		// RAM_Data[18] <= 32'h00004112;
		// RAM_Data[19] <= 32'h0000c399;
		// RAM_Data[20] <= 32'h00004955;
		
		// for (i = 21; i < RAM_SIZE; i = i + 1) begin
		// 	RAM_Data[i] <= 32'h00000000;
        // end


        // used for uart implementation
    
        for (i = 0; i < RAM_SIZE; i = i + 1) begin
        RAM_Data[i] <= 32'h00000000;
        end

	end


	always @(posedge clk or posedge rst) begin
		if (rst) begin
            RAM_Digi <= 12'h0;
            TxByte <= 8'h0;
            TxValid <= 1'b0;
            UART_Ctrl <= 3'b000;


            // // used for sort method and led display simulation only

            // RAM_Data[0] <= 32'h00000014;
            // RAM_Data[1] <= 32'h000041a8;
            // RAM_Data[2] <= 32'h00003af2;
            // RAM_Data[3] <= 32'h0000acda;
            // RAM_Data[4] <= 32'h00000c2b;
            // RAM_Data[5] <= 32'h0000b783;
            // RAM_Data[6] <= 32'h0000dac9;
            // RAM_Data[7] <= 32'h00008ed9;
            // RAM_Data[8] <= 32'h000009ff;
            // RAM_Data[9] <= 32'h00002f44;
            // RAM_Data[10] <= 32'h0000044e;
            // RAM_Data[11] <= 32'h00009899;
            // RAM_Data[12] <= 32'h00003c56;
            // RAM_Data[13] <= 32'h0000128d;
            // RAM_Data[14] <= 32'h0000dbe3;
            // RAM_Data[15] <= 32'h0000d4b4;
            // RAM_Data[16] <= 32'h00003748;
            // RAM_Data[17] <= 32'h00003918;
            // RAM_Data[18] <= 32'h00004112;
            // RAM_Data[19] <= 32'h0000c399;
            // RAM_Data[20] <= 32'h00004955;
            
            // for (i = 21; i < RAM_SIZE; i = i + 1) begin
            //     RAM_Data[i] <= 32'h00000000;
            // end
            

			// used for uart implementation
			
			for (i = 0; i < RAM_SIZE; i = i + 1) begin
				RAM_Data[i] <= 32'h00000000;
			end

		end
		// write data to RAM
		else begin
            if (MemWr) begin
                if (Addr == 32'h40000010) begin
                    RAM_Digi <= WrData[11:0];
                end
                else if (Addr == 32'h40000018) begin
                    TxByte <= WrData[7:0];
                    TxValid <= 1'b1;
                end
                else if (Addr[31:2] < RAM_SIZE) begin
                    RAM_Data[AddrWord] <= WrData;
                end
            end
            if (MemRd && Addr == 32'h40000020) begin
                UART_Ctrl[1:0] <= 2'b00;
            end
            if (RxValid) begin
                RxByte <= RxRd;
                UART_Ctrl[1] <= 1;
            end
            if (TxDone) begin
                TxValid <= 1'b0;
                UART_Ctrl[0] <= 1'b1;
                UART_Ctrl[2] <= 1'b0;
            end
            if (TxActive) begin
                UART_Ctrl[2] <= 1'b1;
            end
		end
    end
			
endmodule
