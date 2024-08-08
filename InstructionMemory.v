module InstructionMemory(
    input [31:0] PC,
    output [31:0] Instruction
);
    reg [31:0] memory [255:0];

    initial begin
        memory[0] = 32'h00000000; 
    end

    assign Instruction = memory[PC[7:2]]; 
endmodule