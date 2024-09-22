module IF_ID (
    input clk,
    input [18:0] IF_instruction,
    input IF_IDwrite,
    input [7:0] IF_pc_plus_one,
    output reg [7:0] ID_pc_plus_one,
    output reg [18:0] ID_instruction
);

    always @(posedge clk) begin
        if (IF_IDwrite) begin
            ID_instruction <= IF_instruction;
            ID_pc_plus_one <= IF_pc_plus_one;
        end
    end

endmodule
