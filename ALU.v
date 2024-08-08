module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUControl,
    output reg [31:0] Result,
    output Zero
);
    always @(*) begin
        case(ALUControl)
            4'b0000: Result = A & B; 
            4'b0001: Result = A | B; 
            4'b0010: Result = A + B; 
            4'b0110: Result = A - B; 
            4'b0111: Result = (A < B) ? 32'd1 : 32'd0; 
            default: Result = 32'd0;
        endcase
    end
    
    assign Zero = (Result == 32'd0);
endmodule
