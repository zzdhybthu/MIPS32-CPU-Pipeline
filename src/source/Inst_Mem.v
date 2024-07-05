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
    
    initial begin
        Inst <= 32'h0;
    end

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


            // binary insert sort test case
        
            9'd0: Inst <= 32'h3c014000;
            9'd1: Inst <= 32'h34300018;
            9'd2: Inst <= 32'h24040000;
            9'd3: Inst <= 32'h2405fffc;
            9'd4: Inst <= 32'h1085001c;
            9'd5: Inst <= 32'h0c10001c;
            9'd6: Inst <= 32'h8e090004;
            9'd7: Inst <= 32'h00094e00;
            9'd8: Inst <= 32'h0c10001c;
            9'd9: Inst <= 32'h8e0a0004;
            9'd10: Inst <= 32'h000a5400;
            9'd11: Inst <= 32'h012a5025;
            9'd12: Inst <= 32'h0c10001c;
            9'd13: Inst <= 32'h8e0b0004;
            9'd14: Inst <= 32'h000b5a00;
            9'd15: Inst <= 32'h014b5825;
            9'd16: Inst <= 32'h0c10001c;
            9'd17: Inst <= 32'h8e0c0004;
            9'd18: Inst <= 32'h016c4025;
            9'd19: Inst <= 32'hac880000;
            9'd20: Inst <= 32'h20840004;
            9'd21: Inst <= 32'h20010000;
            9'd22: Inst <= 32'h1424ffed;
            9'd23: Inst <= 32'h20010004;
            9'd24: Inst <= 32'h71012802;
            9'd25: Inst <= 32'h20a50004;
            9'd26: Inst <= 32'hae05fffc;
            9'd27: Inst <= 32'h08100004;
            9'd28: Inst <= 32'h8e080008;
            9'd29: Inst <= 32'h00084700;
            9'd30: Inst <= 32'h000847c2;
            9'd31: Inst <= 32'h1100fffc;
            9'd32: Inst <= 32'h03e00008;
            9'd33: Inst <= 32'h24100000;
            9'd34: Inst <= 32'h24110000;
            9'd35: Inst <= 32'h8e320000;
            9'd36: Inst <= 32'h22240004;
            9'd37: Inst <= 32'h00122821;
            9'd38: Inst <= 32'h0c100065;
            9'd39: Inst <= 32'hae300000;
            9'd40: Inst <= 32'h08100075;
            9'd41: Inst <= 32'h20010004;
            9'd42: Inst <= 32'h70c14802;
            9'd43: Inst <= 32'h00895020;
            9'd44: Inst <= 32'h8d4d0000;
            9'd45: Inst <= 32'h20010001;
            9'd46: Inst <= 32'h00c14022;
            9'd47: Inst <= 32'h20010004;
            9'd48: Inst <= 32'h01415822;
            9'd49: Inst <= 32'h0105082a;
            9'd50: Inst <= 32'h14200009;
            9'd51: Inst <= 32'h8d6c0000;
            9'd52: Inst <= 32'had4c0000;
            9'd53: Inst <= 32'h20010004;
            9'd54: Inst <= 32'h01415022;
            9'd55: Inst <= 32'h20010004;
            9'd56: Inst <= 32'h01615822;
            9'd57: Inst <= 32'h20010001;
            9'd58: Inst <= 32'h01014022;
            9'd59: Inst <= 32'h08100031;
            9'd60: Inst <= 32'h20010004;
            9'd61: Inst <= 32'h70a14802;
            9'd62: Inst <= 32'h00895020;
            9'd63: Inst <= 32'had4d0000;
            9'd64: Inst <= 32'h03e00008;
            9'd65: Inst <= 32'h20010010;
            9'd66: Inst <= 32'h03a1e822;
            9'd67: Inst <= 32'hafbf0000;
            9'd68: Inst <= 32'hafa50004;
            9'd69: Inst <= 32'hafa60008;
            9'd70: Inst <= 32'hafa7000c;
            9'd71: Inst <= 32'h00c5082a;
            9'd72: Inst <= 32'h14200015;
            9'd73: Inst <= 32'h00a64020;
            9'd74: Inst <= 32'h00084043;
            9'd75: Inst <= 32'h22100001;
            9'd76: Inst <= 32'h20010004;
            9'd77: Inst <= 32'h70e14802;
            9'd78: Inst <= 32'h00895020;
            9'd79: Inst <= 32'h8d4b0000;
            9'd80: Inst <= 32'h20010004;
            9'd81: Inst <= 32'h71014802;
            9'd82: Inst <= 32'h00895020;
            9'd83: Inst <= 32'h8d4c0000;
            9'd84: Inst <= 32'h016c082a;
            9'd85: Inst <= 32'h14200001;
            9'd86: Inst <= 32'h0810005b;
            9'd87: Inst <= 32'h20010001;
            9'd88: Inst <= 32'h01013022;
            9'd89: Inst <= 32'h0c100041;
            9'd90: Inst <= 32'h0810005f;
            9'd91: Inst <= 32'h21050001;
            9'd92: Inst <= 32'h0c100041;
            9'd93: Inst <= 32'h0810005f;
            9'd94: Inst <= 32'h00051021;
            9'd95: Inst <= 32'h8fbf0000;
            9'd96: Inst <= 32'h8fa50004;
            9'd97: Inst <= 32'h8fa60008;
            9'd98: Inst <= 32'h8fa7000c;
            9'd99: Inst <= 32'h23bd0010;
            9'd100: Inst <= 32'h03e00008;
            9'd101: Inst <= 32'h001fa821;
            9'd102: Inst <= 32'h0005b821;
            9'd103: Inst <= 32'h24160001;
            9'd104: Inst <= 32'h02d7082a;
            9'd105: Inst <= 32'h1020000a;
            9'd106: Inst <= 32'h00002821;
            9'd107: Inst <= 32'h20010001;
            9'd108: Inst <= 32'h02c13022;
            9'd109: Inst <= 32'h00163821;
            9'd110: Inst <= 32'h0c100041;
            9'd111: Inst <= 32'h00022821;
            9'd112: Inst <= 32'h00163021;
            9'd113: Inst <= 32'h0c100029;
            9'd114: Inst <= 32'h22d60001;
            9'd115: Inst <= 32'h08100068;
            9'd116: Inst <= 32'h02a00008;
            9'd117: Inst <= 32'h241007ff;
            9'd118: Inst <= 32'h2408003f;
            9'd119: Inst <= 32'hae080000;
            9'd120: Inst <= 32'h24080006;
            9'd121: Inst <= 32'hae08fffc;
            9'd122: Inst <= 32'h2408005b;
            9'd123: Inst <= 32'hae08fff8;
            9'd124: Inst <= 32'h2408004f;
            9'd125: Inst <= 32'hae08fff4;
            9'd126: Inst <= 32'h24080066;
            9'd127: Inst <= 32'hae08fff0;
            9'd128: Inst <= 32'h2408006d;
            9'd129: Inst <= 32'hae08ffec;
            9'd130: Inst <= 32'h2408007d;
            9'd131: Inst <= 32'hae08ffe8;
            9'd132: Inst <= 32'h24080007;
            9'd133: Inst <= 32'hae08ffe4;
            9'd134: Inst <= 32'h2408007f;
            9'd135: Inst <= 32'hae08ffe0;
            9'd136: Inst <= 32'h2408006f;
            9'd137: Inst <= 32'hae08ffdc;
            9'd138: Inst <= 32'h24080077;
            9'd139: Inst <= 32'hae08ffd8;
            9'd140: Inst <= 32'h2408007c;
            9'd141: Inst <= 32'hae08ffd4;
            9'd142: Inst <= 32'h24080039;
            9'd143: Inst <= 32'hae08ffd0;
            9'd144: Inst <= 32'h2408005e;
            9'd145: Inst <= 32'hae08ffcc;
            9'd146: Inst <= 32'h24080079;
            9'd147: Inst <= 32'hae08ffc8;
            9'd148: Inst <= 32'h24080071;
            9'd149: Inst <= 32'hae08ffc4;
            9'd150: Inst <= 32'h3c014000;
            9'd151: Inst <= 32'h34310010;
            9'd152: Inst <= 32'h24080004;
            9'd153: Inst <= 32'h20010004;
            9'd154: Inst <= 32'h72419002;
            9'd155: Inst <= 32'h0248082a;
            9'd156: Inst <= 32'h14200032;
            9'd157: Inst <= 32'h8d0b0000;
            9'd158: Inst <= 32'h000b2700;
            9'd159: Inst <= 32'h00042702;
            9'd160: Inst <= 32'h20010004;
            9'd161: Inst <= 32'h70812002;
            9'd162: Inst <= 32'h02042022;
            9'd163: Inst <= 32'h8c840000;
            9'd164: Inst <= 32'h20840100;
            9'd165: Inst <= 32'h000b2e00;
            9'd166: Inst <= 32'h00052f02;
            9'd167: Inst <= 32'h20010004;
            9'd168: Inst <= 32'h70a12802;
            9'd169: Inst <= 32'h02052822;
            9'd170: Inst <= 32'h8ca50000;
            9'd171: Inst <= 32'h20a50200;
            9'd172: Inst <= 32'h000b3500;
            9'd173: Inst <= 32'h00063702;
            9'd174: Inst <= 32'h20010004;
            9'd175: Inst <= 32'h70c13002;
            9'd176: Inst <= 32'h02063022;
            9'd177: Inst <= 32'h8cc60000;
            9'd178: Inst <= 32'h20c60400;
            9'd179: Inst <= 32'h000b3c00;
            9'd180: Inst <= 32'h00073f02;
            9'd181: Inst <= 32'h20010004;
            9'd182: Inst <= 32'h70e13802;
            9'd183: Inst <= 32'h02073822;
            9'd184: Inst <= 32'h8ce70000;
            9'd185: Inst <= 32'h20e70800;
            9'd186: Inst <= 32'h240900fa;
            9'd187: Inst <= 32'h1120000c;
            9'd188: Inst <= 32'hae240000;
            9'd189: Inst <= 32'h0c1000ca;
            9'd190: Inst <= 32'hae250000;
            9'd191: Inst <= 32'h0c1000ca;
            9'd192: Inst <= 32'hae260000;
            9'd193: Inst <= 32'h0c1000ca;
            9'd194: Inst <= 32'hae270000;
            9'd195: Inst <= 32'h0c1000ca;
            9'd196: Inst <= 32'hae200000;
            9'd197: Inst <= 32'h20010001;
            9'd198: Inst <= 32'h01214822;
            9'd199: Inst <= 32'h081000bb;
            9'd200: Inst <= 32'h21080004;
            9'd201: Inst <= 32'h0810009b;
            9'd202: Inst <= 32'h240a36b0;
            9'd203: Inst <= 32'h20010001;
            9'd204: Inst <= 32'h01415022;
            9'd205: Inst <= 32'h1540fffd;
            9'd206: Inst <= 32'h03e00008;
            9'd207: Inst <= 32'h3c014000;
            9'd208: Inst <= 32'h34300018;
            9'd209: Inst <= 32'h8e05fffc;
            9'd210: Inst <= 32'h24040000;
            9'd211: Inst <= 32'h10850017;
            9'd212: Inst <= 32'h8c880000;
            9'd213: Inst <= 32'h00084e02;
            9'd214: Inst <= 32'h00085200;
            9'd215: Inst <= 32'h000a5602;
            9'd216: Inst <= 32'h00085c00;
            9'd217: Inst <= 32'h000b5e02;
            9'd218: Inst <= 32'h00086600;
            9'd219: Inst <= 32'h000c6602;
            9'd220: Inst <= 32'hae090000;
            9'd221: Inst <= 32'h0c1000e6;
            9'd222: Inst <= 32'hae0a0000;
            9'd223: Inst <= 32'h0c1000e6;
            9'd224: Inst <= 32'hae0b0000;
            9'd225: Inst <= 32'h0c1000e6;
            9'd226: Inst <= 32'hae0c0000;
            9'd227: Inst <= 32'h0c1000e6;
            9'd228: Inst <= 32'h20840004;
            9'd229: Inst <= 32'h081000d3;
            9'd230: Inst <= 32'h8e080008;
            9'd231: Inst <= 32'h00084740;
            9'd232: Inst <= 32'h000847c2;
            9'd233: Inst <= 32'h1100fffc;
            9'd234: Inst <= 32'h03e00008;
            9'd235: Inst <= 32'h081000eb;

        
			default: Inst <= 32'h00000000;
		endcase
		
endmodule
