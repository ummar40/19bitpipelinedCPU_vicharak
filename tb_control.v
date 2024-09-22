module tb_control;

    // Inputs
    reg [4:0] opcode;
    reg hazard;

    // Outputs
    wire ID_branch;
    wire ID_regwrite;
    wire ID_memtoreg;
    wire ID_memread;
    wire ID_memwrite;
    wire ID_alusrc;
    wire ID_aluop;
    wire ID_regdist;
    wire ID_branchtype;
    wire ID_push;
    wire ID_pop;
    wire ID_ret;
    wire ID_jump;

    // Instantiate the Unit Under Test (UUT)
    control uut (
        .opcode(opcode),
        .hazard(hazard),
        .ID_branch(ID_branch),
        .ID_regwrite(ID_regwrite),
        .ID_memtoreg(ID_memtoreg),
        .ID_memread(ID_memread),
        .ID_memwrite(ID_memwrite),
        .ID_alusrc(ID_alusrc),
        .ID_aluop(ID_aluop),
        .ID_regdist(ID_regdist),
        .ID_branchtype(ID_branchtype),
        .ID_push(ID_push),
        .ID_pop(ID_pop),
        .ID_ret(ID_ret),
        .ID_jump(ID_jump)
    );

    initial begin
        // Initialize Inputs
        opcode = 0;
        hazard = 0;

        // Wait for global reset
        #100;

        // Apply test vectors
        opcode = `ART;
        #20;

        opcode = `LOG;
        #20;

        opcode = `JMP;
        #20;

        opcode = `BQE;
        #20;

        opcode = `BNE;
        #20;

        opcode = `CALL;
        #20;

        opcode = `RET;
        #20;

        opcode = `LD;
        #20;

        opcode = `ST;
        #20;

        opcode = `CRY;
        #20;

        opcode = `IMM;
        #20;

        // Finish simulation
        $finish;
    end

endmodule
