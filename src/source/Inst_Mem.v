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
    
    parameter RAM_SIZE = 512;  // 0x00400000 ~ 0x004007FF
    parameter RAM_ADDR_WIDTH = 9;  // 2^9 = 512

	always @(*)
		case (Addr[RAM_ADDR_WIDTH + 1 : 2])

            // // single cycle processor test case 1

            // 9'd0: Inst <= 32'h20042f5b;
            // 9'd1: Inst <= 32'h2405cfc7;
            // 9'd2: Inst <= 32'h00053400;
            // 9'd3: Inst <= 32'h00063c03;
            // 9'd4: Inst <= 32'hac040000;
            // 9'd5: Inst <= 32'h10e50001;
            // 9'd6: Inst <= 32'h3c0456ce;
            // 9'd7: Inst <= 32'h00c44020;
            // 9'd8: Inst <= 32'h00084a03;
            // 9'd9: Inst <= 32'h200ad0a5;
            // 9'd10: Inst <= 32'h008a102a;
            // 9'd11: Inst <= 32'h008a182b;
            // 9'd12: Inst <= 32'h8c0b0000;
            // 9'd13: Inst <= 32'h0810000d;


            // // single cycle processor test case 2

			// 9'd0: Inst<= 32'h20040000;
            // 9'd1: Inst<= 32'h20050020;
            // 9'd2: Inst<= 32'h20100000;
            // 9'd3: Inst<= 32'h8c880000;
            // 9'd4: Inst<= 32'h8c890004;
            // 9'd5: Inst<= 32'h71095002;
            // 9'd6: Inst<= 32'h020a8020;
            // 9'd7: Inst<= 32'h20840008;
            // 9'd8: Inst<= 32'h10850001;
            // 9'd9: Inst<= 32'h08100003;
            // 9'd10: Inst<= 32'hacb00000;
            // 9'd11: Inst<= 32'h0810000b;


            // insert sort test case
            
            9'd0: Inst <= 32'h24100000;
            9'd1: Inst <= 32'h24110000;
            9'd2: Inst <= 32'h8E320000;
            9'd3: Inst <= 32'h22250004;
            9'd4: Inst <= 32'h00123021;
            9'd5: Inst <= 32'h0C100035;
            9'd6: Inst <= 32'hAE300000;
            9'd7: Inst <= 32'h08100042;
            9'd8: Inst <= 32'h20010004;
            9'd9: Inst <= 32'h70E14802;
            9'd10: Inst <= 32'h00A95020;
            9'd11: Inst <= 32'h8D4D0000;
            9'd12: Inst <= 32'h20010001;
            9'd13: Inst <= 32'h00E14022;
            9'd14: Inst <= 32'h20010004;
            9'd15: Inst <= 32'h01415822;
            9'd16: Inst <= 32'h0106082A;
            9'd17: Inst <= 32'h14200009;
            9'd18: Inst <= 32'h8D6C0000;
            9'd19: Inst <= 32'hAD4C0000;
            9'd20: Inst <= 32'h20010004;
            9'd21: Inst <= 32'h01415022;
            9'd22: Inst <= 32'h20010004;
            9'd23: Inst <= 32'h01615822;
            9'd24: Inst <= 32'h20010001;
            9'd25: Inst <= 32'h01014022;
            9'd26: Inst <= 32'h08100010;
            9'd27: Inst <= 32'h20010004;
            9'd28: Inst <= 32'h70C14802;
            9'd29: Inst <= 32'h00A95020;
            9'd30: Inst <= 32'hAD4D0000;
            9'd31: Inst <= 32'h03E00008;
            9'd32: Inst <= 32'h20010004;
            9'd33: Inst <= 32'h70C14802;
            9'd34: Inst <= 32'h00A95020;
            9'd35: Inst <= 32'h8D4B0000;
            9'd36: Inst <= 32'h20010001;
            9'd37: Inst <= 32'h00C14022;
            9'd38: Inst <= 32'h20010004;
            9'd39: Inst <= 32'h01414822;
            9'd40: Inst <= 32'h29010000;
            9'd41: Inst <= 32'h14200009;
            9'd42: Inst <= 32'h22100001;
            9'd43: Inst <= 32'h8D2A0000;
            9'd44: Inst <= 32'h016A082A;
            9'd45: Inst <= 32'h10200005;
            9'd46: Inst <= 32'h20010004;
            9'd47: Inst <= 32'h01214822;
            9'd48: Inst <= 32'h20010001;
            9'd49: Inst <= 32'h01014022;
            9'd50: Inst <= 32'h08100028;
            9'd51: Inst <= 32'h21020001;
            9'd52: Inst <= 32'h03E00008;
            9'd53: Inst <= 32'h001FA821;
            9'd54: Inst <= 32'h0006B821;
            9'd55: Inst <= 32'h24160001;
            9'd56: Inst <= 32'h02D7082A;
            9'd57: Inst <= 32'h10200007;
            9'd58: Inst <= 32'h00163021;
            9'd59: Inst <= 32'h0C100020;
            9'd60: Inst <= 32'h00023021;
            9'd61: Inst <= 32'h00163821;
            9'd62: Inst <= 32'h0C100008;
            9'd63: Inst <= 32'h22D60001;
            9'd64: Inst <= 32'h08100038;
            9'd65: Inst <= 32'h02A00008;


            // // binary insert sort test case
            
            // 9'd0: Inst <= 32'h24100000;
            // 9'd1: Inst <= 32'h24110000;
            // 9'd2: Inst <= 32'h8E320000;
            // 9'd3: Inst <= 32'h22240004;
            // 9'd4: Inst <= 32'h00122821;
            // 9'd5: Inst <= 32'h0C100044;
            // 9'd6: Inst <= 32'hAE300000;
            // 9'd7: Inst <= 32'h08100054;
            // 9'd8: Inst <= 32'h20010004;
            // 9'd9: Inst <= 32'h70C14802;
            // 9'd10: Inst <= 32'h00895020;
            // 9'd11: Inst <= 32'h8D4D0000;
            // 9'd12: Inst <= 32'h20010001;
            // 9'd13: Inst <= 32'h00C14022;
            // 9'd14: Inst <= 32'h20010004;
            // 9'd15: Inst <= 32'h01415822;
            // 9'd16: Inst <= 32'h0105082A;
            // 9'd17: Inst <= 32'h14200009;
            // 9'd18: Inst <= 32'h8D6C0000;
            // 9'd19: Inst <= 32'hAD4C0000;
            // 9'd20: Inst <= 32'h20010004;
            // 9'd21: Inst <= 32'h01415022;
            // 9'd22: Inst <= 32'h20010004;
            // 9'd23: Inst <= 32'h01615822;
            // 9'd24: Inst <= 32'h20010001;
            // 9'd25: Inst <= 32'h01014022;
            // 9'd26: Inst <= 32'h08100010;
            // 9'd27: Inst <= 32'h20010004;
            // 9'd28: Inst <= 32'h70A14802;
            // 9'd29: Inst <= 32'h00895020;
            // 9'd30: Inst <= 32'hAD4D0000;
            // 9'd31: Inst <= 32'h03E00008;
            // 9'd32: Inst <= 32'h20010010;
            // 9'd33: Inst <= 32'h03A1E822;
            // 9'd34: Inst <= 32'hAFBF0000;
            // 9'd35: Inst <= 32'hAFA50004;
            // 9'd36: Inst <= 32'hAFA60008;
            // 9'd37: Inst <= 32'hAFA7000C;
            // 9'd38: Inst <= 32'h00C5082A;
            // 9'd39: Inst <= 32'h14200015;
            // 9'd40: Inst <= 32'h00A64020;
            // 9'd41: Inst <= 32'h00084043;
            // 9'd42: Inst <= 32'h22100001;
            // 9'd43: Inst <= 32'h20010004;
            // 9'd44: Inst <= 32'h70E14802;
            // 9'd45: Inst <= 32'h00895020;
            // 9'd46: Inst <= 32'h8D4B0000;
            // 9'd47: Inst <= 32'h20010004;
            // 9'd48: Inst <= 32'h71014802;
            // 9'd49: Inst <= 32'h00895020;
            // 9'd50: Inst <= 32'h8D4C0000;
            // 9'd51: Inst <= 32'h016C082A;
            // 9'd52: Inst <= 32'h14200001;
            // 9'd53: Inst <= 32'h0810003A;
            // 9'd54: Inst <= 32'h20010001;
            // 9'd55: Inst <= 32'h01013022;
            // 9'd56: Inst <= 32'h0C100020;
            // 9'd57: Inst <= 32'h0810003E;
            // 9'd58: Inst <= 32'h21050001;
            // 9'd59: Inst <= 32'h0C100020;
            // 9'd60: Inst <= 32'h0810003E;
            // 9'd61: Inst <= 32'h00051021;
            // 9'd62: Inst <= 32'h8FBF0000;
            // 9'd63: Inst <= 32'h8FA50004;
            // 9'd64: Inst <= 32'h8FA60008;
            // 9'd65: Inst <= 32'h8FA7000C;
            // 9'd66: Inst <= 32'h23BD0010;
            // 9'd67: Inst <= 32'h03E00008;
            // 9'd68: Inst <= 32'h001FA821;
            // 9'd69: Inst <= 32'h0005B821;
            // 9'd70: Inst <= 32'h24160001;
            // 9'd71: Inst <= 32'h02D7082A;
            // 9'd72: Inst <= 32'h1020000A;
            // 9'd73: Inst <= 32'h00002821;
            // 9'd74: Inst <= 32'h20010001;
            // 9'd75: Inst <= 32'h02C13022;
            // 9'd76: Inst <= 32'h00163821;
            // 9'd77: Inst <= 32'h0C100020;
            // 9'd78: Inst <= 32'h00022821;
            // 9'd79: Inst <= 32'h00163021;
            // 9'd80: Inst <= 32'h0C100008;
            // 9'd81: Inst <= 32'h22D60001;
            // 9'd82: Inst <= 32'h08100047;
            // 9'd83: Inst <= 32'h02A00008;

            
			default: Inst <= 32'h00000000;
		endcase
		
endmodule
