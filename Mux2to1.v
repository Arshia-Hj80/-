module Mux2to1 #(parameter WIDTH = 32)(
    input [WIDTH-1:0] In0,
    input [WIDTH-1:0] In1,
    input Select,
    output [WIDTH-1:0] Out
);
    assign Out = Select ? In1 : In0;
endmodule