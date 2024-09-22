module tb_IF_ID;

    // Inputs
    reg clk;
    reg [18:0] IF_instruction;
    reg IF_IDwrite;
    reg [7:0] IF_pc_plus_one;

    // Outputs
    wire [7:0] ID_pc_plus_one;
    wire [18:0] ID_instruction;

    // Instantiate the Unit Under Test (UUT)
    IF_ID uut (
        .clk(clk),
        .IF_instruction(IF_instruction),
        .IF_IDwrite(IF_IDwrite),
        .IF_pc_plus_one(IF_pc_plus_one),
        .ID_pc_plus_one(ID_pc_plus_one),
        .ID_instruction(ID_instruction)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        IF_instruction = 0;
        IF_IDwrite = 0;
        IF_pc_plus_one = 0;

        // Wait for global reset
        #100;

        // Apply test vectors
        IF_IDwrite = 1;
        IF_instruction = 19'b1010101010101010101;
        IF_pc_plus_one = 8'hFF;

        // Wait for a few clock cycles
        #20;

        // Change inputs
        IF_instruction = 19'b0101010101010101010;
        IF_pc_plus_one = 8'hAA;

        // Wait for a few clock cycles
        #20;

        // Finish simulation
        $finish;
    end

    // Clock generation
    always #10 clk = ~clk;

endmodule
