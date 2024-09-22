`include "E:/ummarVicharaktask/modules/parameter.v"
module alu_control (
    input [4:0] opcode,
    input [4:0] funct,
    output reg [4:0] operation
);
    
    always @(*) begin
        case (opcode)
            `ART: operation = funct;
            `LOG: operation = funct; 
            `CRY: operation = funct; 
            `IMM: operation = `IMMED; 
            `ST: operation = `IMMED; 
            `LD: operation = `IMMED; 
            default: operation = 5'd0;
        endcase
    end

endmodule
