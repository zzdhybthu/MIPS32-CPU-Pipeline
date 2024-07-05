`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/05 16:10:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: UART_RX
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2017.4
// Description: UART_RX
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////

  
module UART_RX #(parameter CLKS_PER_BIT = 7292) (  // 70MHz / 9600bps = 7291.6667
    input clk,         
    input i_Rx_Serial,  // Serial bit input
    output wire [7:0] o_Rx_Byte  // Received Byte
    output wire o_Rx_DV,  // Data Valid, 1 if byte received
);

parameter s_IDLE = 3'b000;
parameter s_RX_START_BIT = 3'b001;
parameter s_RX_DATA_BITS = 3'b010;
parameter s_RX_STOP_BIT = 3'b011;
parameter s_CLEANUP = 3'b100;

reg r_Rx_Data_R = 1'b1;
reg r_Rx_Data = 1'b1;

reg [15:0] r_Clock_Count = 0;
reg [2:0] r_Bit_Index = 0; //8 bits total
reg [7:0] r_Rx_Byte = 0;
reg r_Rx_DV = 0;
reg [2:0] r_SM_Main = 0;


// Purpose: Double-register the incoming data.
// This allows it to be used in the UART RX Clock Domain.
// (It removes problems caused by metastability)
always @(posedge clk) begin
    r_Rx_Data_R <= i_Rx_Serial;
    r_Rx_Data <= r_Rx_Data_R;
end
  
// Purpose: Control RX state machine
always @(posedge clk) begin
    case (r_SM_Main)
        s_IDLE: begin
            r_Rx_DV <= 1'b0;
            r_Clock_Count <= 0;
            r_Bit_Index <= 0;
            if (r_Rx_Data == 1'b0) begin  // Start bit detected
                r_SM_Main <= s_RX_START_BIT;
            end
            else begin
                r_SM_Main <= s_IDLE;
            end
        end
    

        // Check middle of start bit to make sure it's still low
        s_RX_START_BIT: begin
            if (r_Clock_Count == (CLKS_PER_BIT - 1) / 2) begin
                if (r_Rx_Data == 1'b0) begin
                    r_Clock_Count <= 0;  // reset counter, found the middle
                    r_SM_Main <= s_RX_DATA_BITS;
                end
                else begin
                    r_SM_Main <= s_IDLE;
                end
            end
            else begin
                r_Clock_Count <= r_Clock_Count + 1;
                r_SM_Main <= s_RX_START_BIT;
            end
        end  // case: s_RX_START_BIT
        
        
        // Wait CLKS_PER_BIT - 1 clock cycles to sample serial data
        s_RX_DATA_BITS: begin
            if (r_Clock_Count < CLKS_PER_BIT - 1) begin
                r_Clock_Count <= r_Clock_Count + 1;
                r_SM_Main <= s_RX_DATA_BITS;
            end
            else begin
                r_Clock_Count <= 0;
                r_Rx_Byte[r_Bit_Index] <= r_Rx_Data;
                // Check if we have received all bits
                if (r_Bit_Index < 7) begin
                    r_Bit_Index <= r_Bit_Index + 1;
                    r_SM_Main <= s_RX_DATA_BITS;
                end
                else begin
                    r_Bit_Index <= 0;
                    r_SM_Main <= s_RX_STOP_BIT;
                end
            end
        end  // case: s_RX_DATA_BITS
    
    
        // Receive Stop bit.  Stop bit = 1
        s_RX_STOP_BIT: begin
            // Wait CLKS_PER_BIT - 1 clock cycles for Stop bit to finish
            if (r_Clock_Count < CLKS_PER_BIT-1) begin
                r_Clock_Count <= r_Clock_Count + 1;
                r_SM_Main <= s_RX_STOP_BIT;
            end
            else begin
                r_Rx_DV <= 1'b1;
                r_Clock_Count <= 0;
                r_SM_Main <= s_CLEANUP;
            end
        end  // case: s_RX_STOP_BIT
    
        
        // Stay here 1 clock
        s_CLEANUP: begin
            r_SM_Main <= s_IDLE;
            r_Rx_DV <= 1'b0;
        end
        
        
        default: begin
            r_SM_Main <= s_IDLE;
        end
        
    endcase
end   
  
assign o_Rx_DV = r_Rx_DV;
assign o_Rx_Byte = r_Rx_Byte;
   
endmodule
