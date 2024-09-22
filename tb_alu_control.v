module tb_alu_control;

    // Inputs
    reg [4:0] opcode;
    reg [4:0] funct;

    // Outputs
    wire [4:0] operation;

    // Instantiate the Unit Under Test (UUT)
    alu_control uut (
        .opcode(opcode),
        .funct(funct),
        .operation(operation)
    );

    initial begin
        // Initialize Inputs
        opcode = 0;
        funct = 0;

        // Wait for global reset
        #100;

        // Apply test vectors
        opcode = `ART;
        funct = 5'b00001;
        #20;

        opcode = `LOG;
        funct = 5'b00010;
        #20;

        opcode = `CRY;
        funct = 5'b00011;
        #20;

        opcode = `IMM;
        funct = 5'b00100;
        #20;

        opcode = `ST;
        funct = 5'b00101;
        #20;

        opcode = `LD;
        funct = 5'b00110;
        #20;

        // Finish simulation
        $finish;
    end

endmodule
