module ControlUnit(
    input [5:0] OpCode,
    output reg RegDst,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [3:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
);
    always @(*) begin
        case(OpCode)
            6'b000000: begin 
                RegDst = 1'b1;
                ALUSrc = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 4'b0010;
            end
            6'b100011: begin 
                RegDst = 1'b0;
                ALUSrc = 1'b1;
                MemtoReg = 1'b1;
                RegWrite = 1'b1;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 4'b0000;
            end
            6'b101011: begin
                RegDst = 1'bx;
                ALUSrc = 1'b1;
                MemtoReg = 1'bx;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b1;
                Branch = 1'b0;
                ALUOp = 4'b0000;
            end
            default: begin
                RegDst = 1'b0;
                ALUSrc = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 4'b0000;
            end
        endcase
    end
endmodule