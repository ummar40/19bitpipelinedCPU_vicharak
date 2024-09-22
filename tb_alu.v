module tb_alu;

    // Inputs
    reg [18:0] in1;
    reg [18:0] in2;
    reg [4:0] alu_ctrl;

    // Outputs
    wire [18:0] EX_out;

    // Instantiate the Unit Under Test (UUT)
    alu uut (
        .in1(in1),
        .in2(in2),
        .alu_ctrl(alu_ctrl),
        .EX_out(EX_out)
    );

    initial begin
        // Initialize Inputs
        in1 = 0;
        in2 = 0;
        alu_ctrl = 0;

        // Wait for global reset
        #100;

        // Apply test vectors
        in1 = 19'h1A5A5;
        in2 = 19'h15A5A;
        alu_ctrl = `ADD;
        #20;

        alu_ctrl = `SUB;
        #20;

        alu_ctrl = `MUL;
        #20;

        alu_ctrl = `DIV;
        #20;

        alu_ctrl = `AND;
        #20;

        alu_ctrl = `OR;
        #20;

        alu_ctrl = `XOR;
        #20;

        alu_ctrl = `NOT;
        #20;

        alu_ctrl = `ENCRY;
        #20;

        alu_ctrl = `DECRY;
        #20;

        alu_ctrl = `IMMED;
        #20;

        // Finish simulation
        $finish;
    end

endmodule
