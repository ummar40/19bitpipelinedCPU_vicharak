module tb_MEM_WB;

    // Inputs
    reg clk;
    reg MEM_regwrite;
    reg MEM_memtoreg;
    reg [18:0] MEM_rdata;
    reg [18:0] MEM_out;
    reg [2:0] MEM_rd;

    // Outputs
    wire WB_regwrite;
    wire WB_memtoreg;
    wire [18:0] WB_rdata;
    wire [18:0] WB_out;
    wire [2:0] WB_rd;

    // Instantiate the Unit Under Test (UUT)
    MEM_WB uut (
        .clk(clk),
        .MEM_regwrite(MEM_regwrite),
        .MEM_memtoreg(MEM_memtoreg),
        .MEM_rdata(MEM_rdata),
        .MEM_out(MEM_out),
        .MEM_rd(MEM_rd),
        .WB_regwrite(WB_regwrite),
        .WB_memtoreg(WB_memtoreg),
        .WB_rdata(WB_rdata),
        .WB_out(WB_out),
        .WB_rd(WB_rd)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        MEM_regwrite = 0;
        MEM_memtoreg = 0;
        MEM_rdata = 0;
        MEM_out = 0;
        MEM_rd = 0;

        // Wait for global reset
        #100;

        // Apply test vectors
        MEM_regwrite = 1;
        MEM_memtoreg = 1;
        MEM_rdata = 19'h1A5A5;
        MEM_out = 19'h15A5A;
        MEM_rd = 3'b101;

        // Wait for a few clock cycles
        #20;

        // Change inputs
        MEM_regwrite = 0;
        MEM_memtoreg = 0;
        MEM_rdata = 19'h7FFFF;
        MEM_out = 19'h00000;
        MEM_rd = 3'b010;

        // Wait for a few clock cycles
        #20;

        // Finish simulation
        $finish;
    end

    // Clock generation
    always #10 clk = ~clk;

endmodule
