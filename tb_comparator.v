module tb_comparator;

    // Inputs
    reg [18:0] ID_rd1;
    reg [18:0] ID_rd2;

    // Outputs
    wire zero;

    // Instantiate the Unit Under Test (UUT)
    comparator uut (
        .ID_rd1(ID_rd1),
        .ID_rd2(ID_rd2),
        .zero(zero)
    );

    initial begin
        // Initialize Inputs
        ID_rd1 = 0;
        ID_rd2 = 0;

        // Wait for global reset
        #100;

        // Apply test vectors
        ID_rd1 = 19'h1A5A5;
        ID_rd2 = 19'h1A5A5;
        #20;

        ID_rd1 = 19'h15A5A;
        ID_rd2 = 19'h1A5A5;
        #20;

        ID_rd1 = 19'h7FFFF;
        ID_rd2 = 19'h7FFFF;
        #20;

        ID_rd1 = 19'h00000;
        ID_rd2 = 19'h7FFFF;
        #20;

        // Finish simulation
        $finish;
    end

endmodule
