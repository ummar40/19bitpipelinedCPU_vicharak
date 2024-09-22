module tb_EX_MEM;

    // Inputs
    reg clk;
    reg EX_regwrite;
    reg EX_memtoreg;
    reg EX_memread;
    reg EX_memwrite;
    reg [18:0] EX_out;
    reg [18:0] EX_wdata;
    reg [2:0] EX_rd;

    // Outputs
    wire MEM_regwrite;
    wire MEM_memtoreg;
    wire MEM_memread;
    wire MEM_memwrite;
    wire [18:0] MEM_out;
    wire [18:0] MEM_wdata;
    wire [2:0] MEM_rd;

    // Instantiate the Unit Under Test (UUT)
    EX_MEM uut (
        .clk(clk), 
        .EX_regwrite(EX_regwrite), 
        .EX_memtoreg(EX_memtoreg), 
        .EX_memread(EX_memread), 
        .EX_memwrite(EX_memwrite), 
        .EX_out(EX_out), 
        .EX_wdata(EX_wdata), 
        .EX_rd(EX_rd), 
        .MEM_regwrite(MEM_regwrite), 
        .MEM_memtoreg(MEM_memtoreg), 
        .MEM_memread(MEM_memread), 
        .MEM_memwrite(MEM_memwrite), 
        .MEM_out(MEM_out), 
        .MEM_wdata(MEM_wdata), 
        .MEM_rd(MEM_rd)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        EX_regwrite = 0;
        EX_memtoreg = 0;
        EX_memread = 0;
        EX_memwrite = 0;
        EX_out = 0;
        EX_wdata = 0;
        EX_rd = 0;

        // Wait for global reset
        #100;

        // Apply test vectors
        EX_regwrite = 1;
        EX_memtoreg = 1;
        EX_memread = 1;
        EX_memwrite = 1;
        EX_out = 19'h1A5A5;
        EX_wdata = 19'h15A5A;
        EX_rd = 3'b101;

        // Wait for a few clock cycles
        #20;

        // Change inputs
        EX_regwrite = 0;
        EX_memtoreg = 0;
        EX_memread = 0;
        EX_memwrite = 0;
        EX_out = 19'h7FFFF;
        EX_wdata = 19'h00000;
        EX_rd = 3'b010;

        // Wait for a few clock cycles
        #20;

        // Finish simulation
        $finish;
    end

    // Clock generation
    always #10 clk = ~clk;

endmodule
