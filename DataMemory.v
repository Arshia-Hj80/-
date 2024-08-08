module DataMemory(
    input clk,
    input [31:0] Address,
    input [31:0] WriteData,
    input MemRead,
    input MemWrite,
    output reg [31:0] ReadData
);
    reg [31:0] memory [255:0];

    always @(posedge clk) begin
        if (MemWrite)
            memory[Address[7:2]] <= WriteData;
    end

    always @(*) begin
        if (MemRead)
            ReadData = memory[Address[7:2]];
        else
            ReadData = 32'd0;
    end
endmodule