
module ALUControl(
    input [3:0] ALUOp,
    input [5:0] Funct,
    output reg [3:0] ALUControl
);
    always @(*) begin
        case(ALUOp)
            4'b0000: ALUControl = 4'b0010; 
            4'b0001: ALUControl = 4'b0110; 
            4'b0010: 
                case(Funct)
                    6'b100000: ALUControl = 4'b0010; 
                    6'b100010: ALUControl = 4'b0110; 
                    6'b100100: ALUControl = 4'b0000; 
                    6'b100101: ALUControl = 4'b0001; 
                    6'b101010: ALUControl = 4'b0111; 
                    default:   ALUControl = 4'b0000;
                endcase
            default: ALUControl = 4'b0000;
        endcase
    end
endmodule