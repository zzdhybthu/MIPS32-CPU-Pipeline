`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: zzdhybthu
// 
// Create Date: 2024/07/02 12:26:00
// Design Name: MIPS32-CPU-Pipeline
// Module Name: CPU
// Project Name: MIPS32-CPU-Pipeline
// Target Devices: xc7a35tfgg484-1
// Tool Versions: Vivado 2017.4
// Description: CPU
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////


module CPU (
    input rst,
    input clk
);

// PC
wire [31:0] PC;
wire [31:0] PC4;
wire [31:0] PC_Next;
wire PC_Keep;

// IF
wire [31:0] Inst;

// IF/ID
wire [1:0] IF_ID_HzCtrl;
wire [4:0] IF_ID_RsAddr, IF_ID_RtAddr, IF_ID_RdAddr;
wire [5:0] IF_ID_OpCode, IF_ID_Funct;
wire [15:0] IF_ID_Imm;
wire [25:0] IF_ID_JumpAddr;
wire [31:0] IF_ID_PC4;

// ID
wire ExtOp, LuOp, ALUSrc1, ALUSrc2, Branch, RegWr, MemRd, MemWr;
wire [1:0] PCSrc, MemtoReg, RegDst;
wire [3:0] ALUOp;
wire [4:0] ALUCtrl;
wire [31:0] ImmExt;
wire [31:0] RfRdData1, RfRdData2;

// ID/EX
wire LdUseHazard;
wire [1:0] ID_EX_HzCtrl;
wire ID_EX_RegWr;
wire ID_EX_MemRd, ID_EX_MemWr;
wire ID_EX_ALUSrc1, ID_EX_ALUSrc2;
wire ID_EX_LuOp;
wire [1:0] ID_EX_PCSrc;
wire [1:0] ID_EX_RegDst;
wire [1:0] ID_EX_MemtoReg;
wire [3:0] ID_EX_ALUOp;
wire [4:0] ID_EX_RsAddr, ID_EX_RtAddr, ID_EX_RdAddr;
wire [4:0] ID_EX_ALUCtrl;
wire ID_EX_Sign;
wire [5:0] ID_EX_OpCode;
wire [31:0] ID_EX_Rs, ID_EX_Rt, ID_EX_ImmExt;
wire [31:0] ID_EX_PC4;

// EX
wire [1:0] EX_ForwardRs, EX_ForwardRt;
wire [31:0] EX_Src1, EX_Src2;
wire [31:0] ALUIn1, ALUIn2;
wire [31:0] ALUOut;
wire Sign;
wire [4:0] RegWrAddr;

// EX/MEM
wire EX_MEM_MemRd, EX_MEM_MemWr;
wire EX_MEM_RegWr;
wire [1:0] EX_MEM_MemtoReg;
wire [4:0] EX_MEM_RegWrAddr;
wire [4:0] EX_MEM_RtAddr;
wire [31:0] EX_MEM_ALUOut;
wire [31:0] EX_MEM_Rt;
wire [31:0] EX_MEM_PC4;

// MEM
wire MEM_ForwardRt;
wire [31:0] MemWrData, MemRdData;

// MEM/WB
wire MEM_WB_RegWr;
wire [1:0] MEM_WB_MemtoReg;
wire [4:0] MEM_WB_RegWrAddr;
wire [31:0] MEM_WB_ALUOut;
wire [31:0] MEM_WB_MemRdData;
wire [31:0] MEM_WB_PC4;

// WB
wire [31:0] RfWrData;



assign PC_Keep = LdUseHazard ? 1'b1 : 1'b0;  // load-use hazard, keep

assign ImmExt = {ExtOp ? {16{IF_ID_Imm[15]}} : 16'b0, IF_ID_Imm};

assign EX_Src1 = 
                (EX_ForwardRs == 2'b00)? ID_EX_Rs :
                (EX_ForwardRs == 2'b01)? EX_MEM_ALUOut :
                RfWrData;
assign EX_Src2 =
                (EX_ForwardRt == 2'b00)? ID_EX_Rt :
                (EX_ForwardRt == 2'b01)? EX_MEM_ALUOut :
                RfWrData;
assign ALUIn1 = ID_EX_ALUSrc1 ? {27'b0, ID_EX_ImmExt[10:6]} : EX_Src1;
assign ALUIn2 = ID_EX_ALUSrc2 ? (ID_EX_LuOp ? {ID_EX_ImmExt[15:0], 16'b0} : ID_EX_ImmExt) : EX_Src2;

assign RegWrAddr =
                (ID_EX_RegDst == 2'b00)? ID_EX_RtAddr :
                (ID_EX_RegDst == 2'b01)? ID_EX_RdAddr:
                5'b11111;

assign MemWrData = (MEM_ForwardRt == 1'b0)? EX_MEM_Rt : RfWrData;

assign RfWrData = 
                (MEM_WB_MemtoReg == 2'b00)? MEM_WB_ALUOut :
                (MEM_WB_MemtoReg == 2'b01)? MEM_WB_MemRdData:
                MEM_WB_PC4;

assign LdUseHazard = 
                (ID_EX_MemRd && (ID_EX_RtAddr == IF_ID_RsAddr || ID_EX_RtAddr == IF_ID_RtAddr)) ? 1'b1 :
                1'b0;

assign IF_ID_HzCtrl = 
                (Branch || ID_EX_PCSrc == 2'b10 || PCSrc == 2'b01) ? 2'b01 :  // branch or jump register or jump hazard, flush
                LdUseHazard ? 2'b10 :  // load-use hazard, stall
                2'b00;

assign ID_EX_HzCtrl = 
                (Branch || LdUseHazard || ID_EX_PCSrc == 2'b10) ? 2'b01 :  // branch or load-use or jump register hazard, flush
                2'b00;

assign PC_Next = 
                Branch ? (ID_EX_PC4 + (ID_EX_ImmExt << 2)) :  // branch
                ID_EX_PCSrc == 2'b10 ? EX_Src1 :  // jump register
                PCSrc == 2'b01 ? IF_ID_JumpAddr :  // jump
                PC4;  // normal



PC pc (
    .rst(rst),
    .clk(clk),
    .Keep(PC_Keep),
    .PC_Next(PC_Next),
    .PC(PC),
    .PC4(PC4)
);

Inst_Mem inst_mem (
    .Addr(PC),
    .Inst(Inst)
);

IF_ID if_id (
    .rst(rst),
    .clk(clk),
    .HzCtrl(IF_ID_HzCtrl),
    .PC4(PC4),
    .Inst(Inst),
    .IF_ID_RsAddr(IF_ID_RsAddr),
    .IF_ID_RtAddr(IF_ID_RtAddr),
    .IF_ID_RdAddr(IF_ID_RdAddr),
    .IF_ID_Imm(IF_ID_Imm),
    .IF_ID_OpCode(IF_ID_OpCode),
    .IF_ID_Funct(IF_ID_Funct),
    .IF_ID_JumpAddr(IF_ID_JumpAddr),
    .IF_ID_PC4(IF_ID_PC4)
);

RF rf (
    .rst(rst),
    .clk(clk),
    .RsAddr(IF_ID_RsAddr),
    .RtAddr(IF_ID_RtAddr),
    .WrAddr(MEM_WB_RegWrAddr),
    .WrData(RfWrData),
    .RegWr(MEM_WB_RegWr),
    .RdData1(RfRdData1),
    .RdData2(RfRdData2)
);

Ctrl ctrl (
    .OpCode(IF_ID_OpCode),
    .Funct(IF_ID_Funct),
    .PCSrc(PCSrc),
    .RegWr(RegWr),
    .RegDst(RegDst),
    .MemRd(MemRd),
    .MemWr(MemWr),
    .MemtoReg(MemtoReg),
    .ALUSrc1(ALUSrc1),
    .ALUSrc2(ALUSrc2),
    .ExtOp(ExtOp),
    .LuOp(LuOp),
    .ALUOp(ALUOp)
);

ID_EX id_ex (
    .rst(rst),
    .clk(clk),
    .HzCtrl(ID_EX_HzCtrl),
    .PCSrc(PCSrc),
    .Rs(RfRdData1),
    .Rt(RfRdData2),
    .ImmExt(ImmExt),
    .IF_ID_RsAddr(IF_ID_RsAddr),
    .IF_ID_RtAddr(IF_ID_RtAddr),
    .IF_ID_RdAddr(IF_ID_RdAddr),
    .ALUOp(ALUOp),
    .ALUSrc1(ALUSrc1),
    .ALUSrc2(ALUSrc2),
    .Sign(Sign),
    .LuOp(LuOp),
    .RegDst(RegDst),
    .MemRd(MemRd),
    .MemWr(MemWr),
    .MemtoReg(MemtoReg),
    .RegWr(RegWr),
    .IF_ID_PC4(IF_ID_PC4),
    .IF_ID_OpCode(IF_ID_OpCode),
    .ALUCtrl(ALUCtrl),
    .ID_EX_PCSrc(ID_EX_PCSrc),
    .ID_EX_Rs(ID_EX_Rs),
    .ID_EX_Rt(ID_EX_Rt),
    .ID_EX_ImmExt(ID_EX_ImmExt),
    .ID_EX_RsAddr(ID_EX_RsAddr),
    .ID_EX_RtAddr(ID_EX_RtAddr),
    .ID_EX_RdAddr(ID_EX_RdAddr),
    .ID_EX_ALUOp(ID_EX_ALUOp),
    .ID_EX_ALUSrc1(ID_EX_ALUSrc1),
    .ID_EX_ALUSrc2(ID_EX_ALUSrc2),
    .ID_EX_Sign(ID_EX_Sign),
    .ID_EX_LuOp(ID_EX_LuOp),
    .ID_EX_RegDst(ID_EX_RegDst),
    .ID_EX_MemRd(ID_EX_MemRd),
    .ID_EX_MemWr(ID_EX_MemWr),
    .ID_EX_MemtoReg(ID_EX_MemtoReg),
    .ID_EX_RegWr(ID_EX_RegWr),
    .ID_EX_PC4(ID_EX_PC4),
    .ID_EX_OpCode(ID_EX_OpCode),
    .ID_EX_ALUCtrl(ID_EX_ALUCtrl)
);

Forward forward (
    .ID_EX_RsAddr(ID_EX_RsAddr),
    .ID_EX_RtAddr(ID_EX_RtAddr),
    .EX_MEM_RegWrAddr(EX_MEM_RegWrAddr),
    .EX_MEM_RtAddr(EX_MEM_RtAddr),
    .EX_MEM_RegWr(EX_MEM_RegWr),
    .MEM_WB_RegWrAddr(MEM_WB_RegWrAddr),
    .MEM_WB_RegWr(MEM_WB_RegWr),
    .EX_ForwardRs(EX_ForwardRs),
    .EX_ForwardRt(EX_ForwardRt),
    .MEM_ForwardRt(MEM_ForwardRt)
);

ALU_Ctrl alu_ctrl (
    .ALUOp(ALUOp),
    .Funct(IF_ID_Funct),
    .ALUCtrl(ALUCtrl),
    .Sign(Sign)
);

Branch branch (
    .OpCode(ID_EX_OpCode),
    .RsData(EX_Src1),
    .RtData(EX_Src2),
    .Branch(Branch)
);

ALU alu (
    .ALUIn1(ALUIn1),
    .ALUIn2(ALUIn2),
    .ALUCtrl(ID_EX_ALUCtrl),
    .Sign(ID_EX_Sign),
    .ALUOut(ALUOut)
);

EX_MEM ex_mem (
    .rst(rst),
    .clk(clk),
    .RegWrAddr(RegWrAddr),
    .ALUOut(ALUOut),
    .ID_EX_RtAddr(ID_EX_RtAddr),
    .ID_EX_Rt(ID_EX_Rt),
    .ID_EX_MemRd(ID_EX_MemRd),
    .ID_EX_MemWr(ID_EX_MemWr),
    .ID_EX_MemtoReg(ID_EX_MemtoReg),
    .ID_EX_RegWr(ID_EX_RegWr),
    .ID_EX_PC4(ID_EX_PC4),
    .EX_MEM_RegWrAddr(EX_MEM_RegWrAddr),
    .EX_MEM_ALUOut(EX_MEM_ALUOut),
    .EX_MEM_RtAddr(EX_MEM_RtAddr),
    .EX_MEM_Rt(EX_MEM_Rt),
    .EX_MEM_MemRd(EX_MEM_MemRd),
    .EX_MEM_MemWr(EX_MEM_MemWr),
    .EX_MEM_MemtoReg(EX_MEM_MemtoReg),
    .EX_MEM_RegWr(EX_MEM_RegWr),
    .EX_MEM_PC4(EX_MEM_PC4)
);

Data_Mem data_mem (
    .rst(rst),
    .clk(clk),
    .MemRd(EX_MEM_MemRd),
    .MemWr(EX_MEM_MemWr),
    .Addr(EX_MEM_ALUOut),
    .WrData(MemWrData),
    .RdData(MemRdData)
);

MEM_WB mem_wb (
    .rst(rst),
    .clk(clk),
    .MemRdData(MemRdData),
    .EX_MEM_ALUOut(EX_MEM_ALUOut),
    .EX_MEM_RegWrAddr(EX_MEM_RegWrAddr),
    .EX_MEM_MemtoReg(EX_MEM_MemtoReg),
    .EX_MEM_RegWr(EX_MEM_RegWr),
    .EX_MEM_PC4(EX_MEM_PC4),
    .MEM_WB_MemRdData(MEM_WB_MemRdData),
    .MEM_WB_ALUOut(MEM_WB_ALUOut),
    .MEM_WB_RegWrAddr(MEM_WB_RegWrAddr),
    .MEM_WB_MemtoReg(MEM_WB_MemtoReg),
    .MEM_WB_RegWr(MEM_WB_RegWr),
    .MEM_WB_PC4(MEM_WB_PC4)
);



endmodule