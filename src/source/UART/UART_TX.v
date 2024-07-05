`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/05 16:10:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: UART_TX
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2017.4
// Description: UART_TX
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////

  
module UART_TX #(parameter CLKS_PER_BIT = 7292) (  // 70MHz / 9600bps = 7291.6667
    input clk,
    input [7:0] i_Tx_Byte,  // Byte to send
    input i_Tx_DV,  // Data Valid
    output reg o_Tx_Serial,  // Serial bit output
    output wire o_Tx_Active,  // Transmitting
    output wire o_Tx_Done  // Done Transmitting
);
  
    parameter s_IDLE = 3'b000;
    parameter s_TX_START_BIT = 3'b001;
    parameter s_TX_DATA_BITS = 3'b010;
    parameter s_TX_STOP_BIT = 3'b011;
    parameter s_CLEANUP = 3'b100;
    
    reg [2:0] r_SM_Main = 0;
    reg [15:0] r_Clock_Count = 0;
    reg [2:0] r_Bit_Index = 0;
    reg [7:0] r_Tx_Data = 0;
    reg r_Tx_Done = 0;
    reg r_Tx_Active = 0;
        
    always @(posedge clk) begin
        case (r_SM_Main)
            s_IDLE: begin
                o_Tx_Serial <= 1'b1;         // Drive Line High for Idle
                r_Tx_Done <= 1'b0;
                r_Clock_Count <= 0;
                r_Bit_Index <= 0;
                if (i_Tx_DV == 1'b1) begin
                    r_Tx_Active <= 1'b1;
                    r_Tx_Data <= i_Tx_Byte;
                    r_SM_Main <= s_TX_START_BIT;
                end
                else begin
                    r_SM_Main <= s_IDLE;
                end
            end  // case: s_IDLE
            

            // Send out Start Bit. Start bit = 0
            s_TX_START_BIT: begin
                o_Tx_Serial <= 1'b0;
                // Wait CLKS_PER_BIT - 1 clock cycles for start bit to finish
                if (r_Clock_Count < CLKS_PER_BIT - 1) begin
                    r_Clock_Count <= r_Clock_Count + 1;
                    r_SM_Main <= s_TX_START_BIT;
                end
                else begin
                    r_Clock_Count <= 0;
                    r_SM_Main <= s_TX_DATA_BITS;
                end
            end  // case: s_TX_START_BIT
            
            
            // Wait CLKS_PER_BIT - 1 clock cycles for data bits to finish         
            s_TX_DATA_BITS: begin
                o_Tx_Serial <= r_Tx_Data[r_Bit_Index];
                
                if (r_Clock_Count < CLKS_PER_BIT - 1)
                begin
                    r_Clock_Count <= r_Clock_Count + 1;
                    r_SM_Main <= s_TX_DATA_BITS;
                end
                else
                begin
                    r_Clock_Count <= 0;
                    
                    // Check if we have sent out all bits
                    if (r_Bit_Index < 7)
                    begin
                        r_Bit_Index <= r_Bit_Index + 1;
                        r_SM_Main <= s_TX_DATA_BITS;
                    end
                    else
                    begin
                        r_Bit_Index <= 0;
                        r_SM_Main <= s_TX_STOP_BIT;
                    end
                end
            end  // case: s_TX_DATA_BITS
            
            
            // Send out Stop bit.  Stop bit = 1
            s_TX_STOP_BIT: begin
                o_Tx_Serial <= 1'b1;
                // Wait CLKS_PER_BIT - 1 clock cycles for Stop bit to finish
                if (r_Clock_Count < CLKS_PER_BIT - 1) begin
                    r_Clock_Count <= r_Clock_Count + 1;
                    r_SM_Main <= s_TX_STOP_BIT;
                end
                else begin
                    r_Tx_Done <= 1'b1;
                    r_Clock_Count <= 0;
                    r_SM_Main <= s_CLEANUP;
                    r_Tx_Active <= 1'b0;
                end
            end  // case: s_Tx_STOP_BIT
            
            
            // Stay here 1 clock
            s_CLEANUP: begin
                r_Tx_Done <= 1'b1;
                r_SM_Main <= s_IDLE;
            end
            
            
            default: begin
                r_SM_Main <= s_IDLE;
            end
            
        endcase
    end
    
    assign o_Tx_Active = r_Tx_Active;
    assign o_Tx_Done = r_Tx_Done;
    
endmodule
