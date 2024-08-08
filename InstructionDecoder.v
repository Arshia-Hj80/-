module InstructionDecoder(
    input [31:0] Instruction,
    output [5:0] OpCode,
    output [4:0] Rs,
    output [4:0] Rt,
    output [4:0] Rd,
    output [4:0] Shamt,
    output [5:0] Funct,
    output [15:0] Immediate
);
    assign OpCode = Instruction[31:26];
    assign Rs = Instruction[25:21];
    assign Rt = Instruction[20:16];
    assign Rd = Instruction[15:11];
    assign Shamt = Instruction[10:6];
    assign Funct = Instruction[5:0];
    assign Immediate = Instruction[15:0];
endmodule