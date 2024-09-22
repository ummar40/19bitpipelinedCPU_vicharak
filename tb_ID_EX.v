module tb_ID_EX;

    // Inputs
    reg clk;
    reg [4:0] ID_opcode;
    reg ID_regwrite;
    reg ID_memtoreg;
    reg ID_memread;
    reg ID_memwrite;
    reg ID_alusrc;
    reg ID_aluop;
    reg ID_regdist;
    reg [7:0] ID_immediate;
    reg [2:0] ID_rs;
    reg [2:0] ID_rt;
    reg [2:0] ID_rd;
    reg [18:0] ID_rd1;
    reg [18:0] ID_rd2;

    // Outputs
    wire [4:0] EX_opcode;
    wire EX_regwrite;
    wire EX_memtoreg;
    wire EX_memread;
    wire EX_memwrite;
    wire EX_alusrc;
    wire EX_aluop;
    wire EX_regdist;
    wire [7:0] EX_immediate;
    wire [2:0] EX_rs;
    wire [2:0] EX_rt;
    wire [2:0] EX_rd;
    wire [18:0] EX_rd1;
    wire [18:0] EX_rd2;

    // Instantiate the Unit Under Test (UUT)
    ID_EX uut (
        .clk(clk),
        .ID_opcode(ID_opcode),
        .ID_regwrite(ID_regwrite),
        .ID_memtoreg(ID_memtoreg),
        .ID_memread(ID_memread),
        .ID_memwrite(ID_memwrite),
        .ID_alusrc(ID_alusrc),
        .ID_aluop(ID_aluop),
        .ID_regdist(ID_regdist),
        .ID_immediate(ID_immediate),
        .ID_rs(ID_rs),
        .ID_rt(ID_rt),
        .ID_rd(ID_rd),
        .ID_rd1(ID_rd1),
        .ID_rd2(ID_rd2),
        .EX_opcode(EX_opcode),
        .EX_regwrite(EX_regwrite),
        .EX_memtoreg(EX_memtoreg),
        .EX_memread(EX_memread),
        .EX_memwrite(EX_memwrite),
        .EX_alusrc(EX_alusrc),
        .EX_aluop(EX_aluop),
        .EX_regdist(EX_regdist),
        .EX_immediate(EX_immediate),
        .EX_rs(EX_rs),
        .EX_rt(EX_rt),
        .EX_rd(EX_rd),
        .EX_rd1(EX_rd1),
        .EX_rd2(EX_rd2)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        ID_opcode = 0;
        ID_regwrite = 0;
        ID_memtoreg = 0;
        ID_memread = 0;
        ID_memwrite = 0;
        ID_alusrc = 0;
        ID_aluop = 0;
        ID_regdist = 0;
        ID_immediate = 0;
        ID_rs = 0;
        ID_rt = 0;
        ID_rd = 0;
        ID_rd1 = 0;
        ID_rd2 = 0;

        // Wait for global reset
        #100;

        // Apply test vectors
        ID_opcode = 5'b10101;
        ID_regwrite = 1;
        ID_memtoreg = 1;
        ID_memread = 1;
        ID_memwrite = 1;
        ID_alusrc = 1;
        ID_aluop = 1;
        ID_regdist = 1;
        ID_immediate = 8'hFF;
        ID_rs = 3'b101;
        ID_rt = 3'b110;
        ID_rd = 3'b111;
        ID_rd1 = 19'h1A5A5;
        ID_rd2 = 19'h15A5A;

        // Wait for a few clock cycles
        #20;

        // Change inputs
        ID_opcode = 5'b01010;
        ID_regwrite = 0;
        ID_memtoreg = 0;
        ID_memread = 0;
        ID_memwrite = 0;
        ID_alusrc = 0;
        ID_aluop = 0;
        ID_regdist = 0;
        ID_immediate = 8'h00;
        ID_rs = 3'b001;
        ID_rt = 3'b010;
        ID_rd = 3'b011;
        ID_rd1 = 19'h7FFFF;
        ID_rd2 = 19'h00000;

        // Wait for a few clock cycles
        #20;

        // Finish simulation
        $finish;
    end

    // Clock generation
    always #10 clk = ~clk;

endmodule
