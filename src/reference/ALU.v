// Hint: ALU port may be changed (for question 3)
module ALU(
	input [32 -1:0] in1      , 
	input [32 -1:0] in2      ,
	input [5 -1:0] ALUCtl    ,
	input Sign               ,
	output reg [32 -1:0] out ,
	output reg [32 -1:0] out2,
	output zero
);
	// zero means whether the output is zero or not
	assign zero = (out == 0);
	
	wire ss;
	assign ss = {in1[31], in2[31]};
	
	wire lt_31;
	assign lt_31 = (in1[30:0] < in2[30:0]);
	
	// lt_signed means whether (in1 < in2)
	wire lt_signed;
	assign lt_signed = (in1[31] ^ in2[31])? 
		((ss == 2'b01)? 0: 1): lt_31;
	

	// different ALU operations
	always @(*) begin
		case (ALUCtl)
			5'b00000: out <= in1 & in2;
			5'b00001: out <= in1 | in2;
			5'b00010: out <= in1 + in2;
			5'b00110: out <= in1 - in2;
			5'b00111: out <= {31'h00000000, Sign? lt_signed: (in1 < in2)};
			5'b01100: out <= ~(in1 | in2);
			5'b01101: out <= in1 ^ in2;
			5'b10000: out <= (in2 << in1[4:0]);
			5'b11000: out <= (in2 >> in1[4:0]);
			5'b11001: out <= ({{32{in2[31]}}, in2} >> in1[4:0]);
			5'b11010: out <= in1 * in2; // mul
			5'b11011: out <= $signed(in1[31:24]) * $signed(in2[31:24]) + 
			                 $signed(in1[23:16]) * $signed(in2[23:16]) + 
			                 $signed(in1[15:8]) * $signed(in2[15:8]) + 
			                 $signed(in1[7:0]) * $signed(in2[7:0]); // mac
			5'b11100: out <= (in2[31] == 0)? in2: 32'h00000000; // relu, rd
			default: out <= 32'h00000000;
		endcase
		case (ALUCtl)
			5'b11100: out2 <= (in1[31] == 0)? in1: 32'h00000000; // relu, rs
			default: out2 <= 32'h00000000;
		endcase
	end
	
	
endmodule