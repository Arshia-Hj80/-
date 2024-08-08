module SignExtender(
    input [15:0] Immediate,
    output [31:0] SignExtended
);
    assign SignExtended = {{16{Immediate[15]}}, Immediate};
endmodule