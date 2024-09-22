module ID_EX(
    input clk,
    input [4:0] ID_opcode,
    input ID_regwrite,
    input ID_memtoreg,
    input ID_memread,
    input ID_memwrite,
    input ID_alusrc,
    input ID_aluop,
    input ID_regdist,
    input [7:0] ID_immediate,
    input [2:0] ID_rs,
    input [2:0] ID_rt,
    input [2:0] ID_rd,
    input [31:0] ID_rd1,
    input [31:0] ID_rd2,
    output reg [4:0] EX_opcode,
    output reg EX_regwrite,
    output reg EX_memtoreg,
    output reg EX_memread,
    output reg EX_memwrite,
    output reg EX_alusrc,
    output reg EX_aluop,
    output reg EX_regdist,
    output reg [7:0] EX_immediate,
    output reg [2:0] EX_rs,
    output reg [2:0] EX_rt,
    output reg [2:0] EX_rd,
    output reg [18:0] EX_rd1,
    output reg [18:0] EX_rd2
);

    always @(posedge clk) begin
        EX_opcode <= ID_opcode;
        EX_regwrite <= ID_regwrite;
        EX_memtoreg <= ID_memtoreg;
        EX_memread <= ID_memread;
        EX_memwrite <= ID_memwrite;
        EX_alusrc <= ID_alusrc;
        EX_aluop <= ID_aluop;
        EX_regdist <= ID_regdist;
        EX_immediate <= ID_immediate;
        EX_rs <= ID_rs;
        EX_rt <= ID_rt;
        EX_rd <= ID_rd;
        EX_rd1 <= ID_rd1;
        EX_rd2 <= ID_rd2;
    end

endmodule
