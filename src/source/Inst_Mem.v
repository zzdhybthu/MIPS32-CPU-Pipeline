`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/01 20:00:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: Inst_Mem
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2017.4
// Description: Instruction Memory, ROM
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module Inst_Mem (
	input [31:0] Addr, 
	output reg [31:0] Inst
);
	
	always @(*)
		case (Addr[9:2])

            // // single cycle processor test case 1

            // 8'd0: Inst <= 32'h20042f5b;
            // 8'd1: Inst <= 32'h2405cfc7;
            // 8'd2: Inst <= 32'h00053400;
            // 8'd3: Inst <= 32'h00063c03;
            // 8'd4: Inst <= 32'hac040000;
            // 8'd5: Inst <= 32'h10e50001;
            // 8'd6: Inst <= 32'h3c0456ce;
            // 8'd7: Inst <= 32'h00c44020;
            // 8'd8: Inst <= 32'h00084a03;
            // 8'd9: Inst <= 32'h200ad0a5;
            // 8'd10: Inst <= 32'h008a102a;
            // 8'd11: Inst <= 32'h008a182b;
            // 8'd12: Inst <= 32'h8c0b0000;
            // 8'd13: Inst <= 32'h0810000d;


            // // single cycle processor test case 2

			// 8'd0: Inst<= 32'h20040000;
            // 8'd1: Inst<= 32'h20050020;
            // 8'd2: Inst<= 32'h20100000;
            // 8'd3: Inst<= 32'h8c880000;
            // 8'd4: Inst<= 32'h8c890004;
            // 8'd5: Inst<= 32'h71095002;
            // 8'd6: Inst<= 32'h020a8020;
            // 8'd7: Inst<= 32'h20840008;
            // 8'd8: Inst<= 32'h10850001;
            // 8'd9: Inst<= 32'h08100003;
            // 8'd10: Inst<= 32'hacb00000;
            // 8'd11: Inst<= 32'h0810000b;


            // insert sort test case
            
            8'd0: Inst <= 32'h24100000;
            8'd1: Inst <= 32'h24110000;
            8'd2: Inst <= 32'h8E320000;
            8'd3: Inst <= 32'h22250004;
            8'd4: Inst <= 32'h00123021;
            8'd5: Inst <= 32'h0C100035;
            8'd6: Inst <= 32'hAE300000;
            8'd7: Inst <= 32'h08100042;
            8'd8: Inst <= 32'h20010004;
            8'd9: Inst <= 32'h70E14802;
            8'd10: Inst <= 32'h00A95020;
            8'd11: Inst <= 32'h8D4D0000;
            8'd12: Inst <= 32'h20010001;
            8'd13: Inst <= 32'h00E14022;
            8'd14: Inst <= 32'h20010004;
            8'd15: Inst <= 32'h01415822;
            8'd16: Inst <= 32'h0106082A;
            8'd17: Inst <= 32'h14200009;
            8'd18: Inst <= 32'h8D6C0000;
            8'd19: Inst <= 32'hAD4C0000;
            8'd20: Inst <= 32'h20010004;
            8'd21: Inst <= 32'h01415022;
            8'd22: Inst <= 32'h20010004;
            8'd23: Inst <= 32'h01615822;
            8'd24: Inst <= 32'h20010001;
            8'd25: Inst <= 32'h01014022;
            8'd26: Inst <= 32'h08100010;
            8'd27: Inst <= 32'h20010004;
            8'd28: Inst <= 32'h70C14802;
            8'd29: Inst <= 32'h00A95020;
            8'd30: Inst <= 32'hAD4D0000;
            8'd31: Inst <= 32'h03E00008;
            8'd32: Inst <= 32'h20010004;
            8'd33: Inst <= 32'h70C14802;
            8'd34: Inst <= 32'h00A95020;
            8'd35: Inst <= 32'h8D4B0000;
            8'd36: Inst <= 32'h20010001;
            8'd37: Inst <= 32'h00C14022;
            8'd38: Inst <= 32'h20010004;
            8'd39: Inst <= 32'h01414822;
            8'd40: Inst <= 32'h29010000;
            8'd41: Inst <= 32'h14200009;
            8'd42: Inst <= 32'h22100001;
            8'd43: Inst <= 32'h8D2A0000;
            8'd44: Inst <= 32'h016A082A;
            8'd45: Inst <= 32'h10200005;
            8'd46: Inst <= 32'h20010004;
            8'd47: Inst <= 32'h01214822;
            8'd48: Inst <= 32'h20010001;
            8'd49: Inst <= 32'h01014022;
            8'd50: Inst <= 32'h08100028;
            8'd51: Inst <= 32'h21020001;
            8'd52: Inst <= 32'h03E00008;
            8'd53: Inst <= 32'h001FA821;
            8'd54: Inst <= 32'h0006B821;
            8'd55: Inst <= 32'h24160001;
            8'd56: Inst <= 32'h02D7082A;
            8'd57: Inst <= 32'h10200007;
            8'd58: Inst <= 32'h00163021;
            8'd59: Inst <= 32'h0C100020;
            8'd60: Inst <= 32'h00023021;
            8'd61: Inst <= 32'h00163821;
            8'd62: Inst <= 32'h0C100008;
            8'd63: Inst <= 32'h22D60001;
            8'd64: Inst <= 32'h08100038;
            8'd65: Inst <= 32'h02A00008;


            // // binary insert sort test case
            
            // 8'd0: Inst <= 32'h24100000;
            // 8'd1: Inst <= 32'h24110000;
            // 8'd2: Inst <= 32'h8E320000;
            // 8'd3: Inst <= 32'h22240004;
            // 8'd4: Inst <= 32'h00122821;
            // 8'd5: Inst <= 32'h0C100044;
            // 8'd6: Inst <= 32'hAE300000;
            // 8'd7: Inst <= 32'h08100054;
            // 8'd8: Inst <= 32'h20010004;
            // 8'd9: Inst <= 32'h70C14802;
            // 8'd10: Inst <= 32'h00895020;
            // 8'd11: Inst <= 32'h8D4D0000;
            // 8'd12: Inst <= 32'h20010001;
            // 8'd13: Inst <= 32'h00C14022;
            // 8'd14: Inst <= 32'h20010004;
            // 8'd15: Inst <= 32'h01415822;
            // 8'd16: Inst <= 32'h0105082A;
            // 8'd17: Inst <= 32'h14200009;
            // 8'd18: Inst <= 32'h8D6C0000;
            // 8'd19: Inst <= 32'hAD4C0000;
            // 8'd20: Inst <= 32'h20010004;
            // 8'd21: Inst <= 32'h01415022;
            // 8'd22: Inst <= 32'h20010004;
            // 8'd23: Inst <= 32'h01615822;
            // 8'd24: Inst <= 32'h20010001;
            // 8'd25: Inst <= 32'h01014022;
            // 8'd26: Inst <= 32'h08100010;
            // 8'd27: Inst <= 32'h20010004;
            // 8'd28: Inst <= 32'h70A14802;
            // 8'd29: Inst <= 32'h00895020;
            // 8'd30: Inst <= 32'hAD4D0000;
            // 8'd31: Inst <= 32'h03E00008;
            // 8'd32: Inst <= 32'h20010010;
            // 8'd33: Inst <= 32'h03A1E822;
            // 8'd34: Inst <= 32'hAFBF0000;
            // 8'd35: Inst <= 32'hAFA50004;
            // 8'd36: Inst <= 32'hAFA60008;
            // 8'd37: Inst <= 32'hAFA7000C;
            // 8'd38: Inst <= 32'h00C5082A;
            // 8'd39: Inst <= 32'h14200015;
            // 8'd40: Inst <= 32'h00A64020;
            // 8'd41: Inst <= 32'h00084043;
            // 8'd42: Inst <= 32'h22100001;
            // 8'd43: Inst <= 32'h20010004;
            // 8'd44: Inst <= 32'h70E14802;
            // 8'd45: Inst <= 32'h00895020;
            // 8'd46: Inst <= 32'h8D4B0000;
            // 8'd47: Inst <= 32'h20010004;
            // 8'd48: Inst <= 32'h71014802;
            // 8'd49: Inst <= 32'h00895020;
            // 8'd50: Inst <= 32'h8D4C0000;
            // 8'd51: Inst <= 32'h016C082A;
            // 8'd52: Inst <= 32'h14200001;
            // 8'd53: Inst <= 32'h0810003A;
            // 8'd54: Inst <= 32'h20010001;
            // 8'd55: Inst <= 32'h01013022;
            // 8'd56: Inst <= 32'h0C100020;
            // 8'd57: Inst <= 32'h0810003E;
            // 8'd58: Inst <= 32'h21050001;
            // 8'd59: Inst <= 32'h0C100020;
            // 8'd60: Inst <= 32'h0810003E;
            // 8'd61: Inst <= 32'h00051021;
            // 8'd62: Inst <= 32'h8FBF0000;
            // 8'd63: Inst <= 32'h8FA50004;
            // 8'd64: Inst <= 32'h8FA60008;
            // 8'd65: Inst <= 32'h8FA7000C;
            // 8'd66: Inst <= 32'h23BD0010;
            // 8'd67: Inst <= 32'h03E00008;
            // 8'd68: Inst <= 32'h001FA821;
            // 8'd69: Inst <= 32'h0005B821;
            // 8'd70: Inst <= 32'h24160001;
            // 8'd71: Inst <= 32'h02D7082A;
            // 8'd72: Inst <= 32'h1020000A;
            // 8'd73: Inst <= 32'h00002821;
            // 8'd74: Inst <= 32'h20010001;
            // 8'd75: Inst <= 32'h02C13022;
            // 8'd76: Inst <= 32'h00163821;
            // 8'd77: Inst <= 32'h0C100020;
            // 8'd78: Inst <= 32'h00022821;
            // 8'd79: Inst <= 32'h00163021;
            // 8'd80: Inst <= 32'h0C100008;
            // 8'd81: Inst <= 32'h22D60001;
            // 8'd82: Inst <= 32'h08100047;
            // 8'd83: Inst <= 32'h02A00008;

            
			default: Inst <= 32'h00000000;
		endcase
		
endmodule
