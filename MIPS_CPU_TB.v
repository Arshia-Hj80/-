module MIPS_CPU_TB;
    reg clk;
    reg reset;

    MIPS_CPU uut(
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        reset = 1;
        
        // Reset the CPU
        #10 reset = 0;

        uut.im.memory[0] = 32'h00430820; // add $1, $2, $3 (R-type: $1 = $2 + $3)
        uut.im.memory[1] = 32'hAC010000; // sw $1, 0($0) (Store result to memory address 0)
        uut.im.memory[2] = 32'h8C040000; // lw $4, 0($0) (Load from memory address 0 to $4)

        uut.rf.registers[2] = 32'd5;  // $2 = 5
        uut.rf.registers[3] = 32'd6;  // $3 = 6

        $display("Initial values:");
        $display("$2 = %d, $3 = %d", uut.rf.registers[2], uut.rf.registers[3]);
        $display("-----------------------------");

        #20;
        $display("After add $1, $2, $3:");
        $display("$1 = %d", uut.rf.registers[1]);
        $display("Expected: $1 = 11");
        $display("-----------------------------");

        #20;
        $display("After sw $1, 0($0):");
        $display("mem[0] = %d", uut.dm.memory[0]);
        $display("Expected: mem[0] = 11");
        $display("-----------------------------");

        #20; 
        $display("After lw $4, 0($0):");
        $display("$4 = %d", uut.rf.registers[4]);
        $display("Expected: $4 = 11");
        $display("-----------------------------");

        $display("Final check:");
        if (uut.rf.registers[1] == 32'd11)
            $display("R-type (add) instruction passed");
        else
            $display("R-type (add) instruction failed");

        if (uut.dm.memory[0] == 32'd11)
            $display("sw instruction passed");
        else
            $display("sw instruction failed");

        if (uut.rf.registers[4] == 32'd11)
            $display("lw instruction passed");
        else
            $display("lw instruction failed");

        $finish;
    end

endmodule