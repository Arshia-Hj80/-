module MIPS_CPU(
    input clk,
    input reset
);
    // Wires
    wire [31:0] PC, NextPC, Instruction, ReadData1, ReadData2, WriteData, ALUResult, MemoryReadData;
    wire [31:0] SignExtendedImm, ALUInput2;
    wire [4:0] WriteRegister;
    wire [3:0] ALUControl;
    wire Zero, RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    wire [5:0] OpCode, Funct;
    wire [4:0] Rs, Rt, Rd, Shamt;
    wire [15:0] Immediate;

    // Program Counter
    ProgramCounter pc(
        .clk(clk),
        .reset(reset),
        .NextPC(NextPC),
        .PC(PC)
    );

    // Instruction Memory
    InstructionMemory im(
        .PC(PC),
        .Instruction(Instruction)
    );

    // Instruction Decoder
    InstructionDecoder id(
        .Instruction(Instruction),
        .OpCode(OpCode),
        .Rs(Rs),
        .Rt(Rt),
        .Rd(Rd),
        .Shamt(Shamt),
        .Funct(Funct),
        .Immediate(Immediate)
    );

    // Control Unit
    ControlUnit cu(
        .OpCode(OpCode),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUControl),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite)
    );

    // Register File
    RegisterFile rf(
        .clk(clk),
        .reset(reset),
        .ReadReg1(Rs),
        .ReadReg2(Rt),
        .WriteReg(WriteRegister),
        .WriteData(WriteData),
        .RegWrite(RegWrite),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    // Sign Extender
    SignExtender se(
        .Immediate(Immediate),
        .SignExtended(SignExtendedImm)
    );

    // ALU
    ALU alu(
        .A(ReadData1),
        .B(ALUInput2),
        .ALUControl(ALUControl),
        .Result(ALUResult),
        .Zero(Zero)
    );

    // Data Memory
    DataMemory dm(
        .clk(clk),
        .Address(ALUResult),
        .WriteData(ReadData2),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ReadData(MemoryReadData)
    );

    // Multiplexers
    Mux2to1 #(5) regDstMux(
        .In0(Rt),
        .In1(Rd),
        .Select(RegDst),
        .Out(WriteRegister)
    );

    Mux2to1 #(32) aluSrcMux(
        .In0(ReadData2),
        .In1(SignExtendedImm),
        .Select(ALUSrc),
        .Out(ALUInput2)
    );

    Mux2to1 #(32) memToRegMux(
        .In0(ALUResult),
        .In1(MemoryReadData),
        .Select(MemtoReg),
        .Out(WriteData)
    );

    // Next PC calculation
    assign NextPC = PC + 4;

endmodule