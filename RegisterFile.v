module RegisterFile(
    input clk,
    input reset,
    input [4:0] ReadReg1,
    input [4:0] ReadReg2,
    input [4:0] WriteReg,
    input [31:0] WriteData,
    input RegWrite,
    output [31:0] ReadData1,
    output [31:0] ReadData2
);
    reg [31:0] registers [31:0];
    integer i;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'd0;
            end
        end else if (RegWrite && WriteReg != 5'd0) begin
            registers[WriteReg] <= WriteData;
        end
    end

    assign ReadData1 = (ReadReg1 == 5'd0) ? 32'd0 : registers[ReadReg1];
    assign ReadData2 = (ReadReg2 == 5'd0) ? 32'd0 : registers[ReadReg2];
endmodule