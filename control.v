`include "E:/ummarVicharaktask/modules/parameter.v"

module control(
    input [4:0] opcode,
    input hazard,
    output reg ID_branch,
    output reg ID_regwrite,
    output reg ID_memtoreg,
    output reg ID_memread,
    output reg ID_memwrite,
    output reg ID_alusrc,
    output reg ID_aluop,
    output reg ID_regdist,
    output reg ID_branchtype,
    output reg ID_push,
    output reg ID_pop,
    output reg ID_ret,
    output reg ID_jump
);

    always @(*) begin
        // Default values
        ID_branch = 1'b0;
        ID_regwrite = 1'b0;
        ID_memtoreg = 1'b0;
        ID_memread = 1'b0;
        ID_memwrite = 1'b0;
        ID_alusrc = 1'b0;
        ID_aluop = 1'b0;
        ID_regdist = 1'b0;
        ID_branchtype = 1'b0;
        ID_push = 1'b0;
        ID_pop = 1'b0;
        ID_ret = 1'b0;
        ID_jump = 1'b0;

        if (!hazard) begin
            case (opcode)
                `ART: begin
                    ID_regdist = 1'b1;
                    ID_regwrite = 1'b1;
                end 
                `LOG: begin
                    ID_regdist = 1'b1;
                    ID_regwrite = 1'b1;
                end 
                `JMP: begin
                    ID_jump = 1'b1;
                end
                `BQE: begin
                    ID_branch = 1'b1;
                    ID_branchtype = 1'b0;
                end 
                `BNE: begin
                    ID_branch = 1'b1;
                    ID_branchtype = 1'b1;
                end 
                `CALL: begin
                    ID_push = 1'b1;
                    ID_jump = 1'b1;
                end
                `RET: begin
                    ID_pop = 1'b1;
                    ID_ret = 1'b1;
                end
                `LD: begin
                    ID_memread = 1'b1;
                    ID_memtoreg = 1'b1;
                    ID_regwrite = 1'b1;
                    ID_alusrc = 1'b1;
                end
                `ST: begin
                    ID_memwrite = 1'b1;
                    ID_alusrc = 1'b1;
                end
                `CRY: begin
                    ID_regwrite = 1'b1;
                end          
                `IMM: begin
                    ID_regwrite = 1'b1;
                    ID_alusrc = 1'b1;
                end               
                default: begin
                    // Default case
                end
            endcase
        end
    end

endmodule
