module MEM_WB (
    input clk,
    input MEM_regwrite,
    input MEM_memtoreg,
    input [18:0] MEM_rdata,
    input [18:0] MEM_out,
    input [2:0] MEM_rd,
    output reg WB_regwrite,
    output reg WB_memtoreg,
    output reg [18:0] WB_rdata,
    output reg [18:0] WB_out,
    output reg [2:0] WB_rd
);

always @(posedge clk ) begin
    WB_regwrite <= MEM_regwrite;
    WB_memtoreg <= MEM_memtoreg;
    WB_rdata <= MEM_rdata;
    WB_out <= MEM_out;
    WB_rd <= MEM_rd;
end
    
endmodule
