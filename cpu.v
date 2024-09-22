//Now we'll write cpu.v module
module cpu(
    input clk,
	input reset
);
 
    wire [7:0] ret_mux_pc;
	wire [7:0] pc;
	wire pcwrite;
	
    pc pc_cpu (
        .clk(clk),
        .reset(reset),
        .pcwrite(pcwrite),
        .next_pc(ret_mux_pc),
        .pc(pc)
    );
	
	wire [18:0] IF_instruction;
	
    inst_mem inst_mem_cpu(          //calling inst_mem.v
        .pc(pc),
        .instruction(IF_instruction)
    );
	
    wire [7:0] IF_pc_plus_one;
    assign IF_pc_plus_one = pc + 1;
    wire [7:0] ID_pc_plus_one;
    wire [18:0] ID_instruction;

    wire branch_signal;
	
    IF_ID IF_ID_cpu (                      //calling IF_ID.v
        .clk(clk),
        .IF_instruction(IF_instruction),
        .IF_IDwrite(IF_IDwrite),
        .IF_pc_plus_one(IF_pc_plus_one),
        .ID_pc_plus_one(ID_pc_plus_one),
        .ID_instruction(ID_instruction)
    );

    wire ID_branch, ID_regwrite, ID_memtoreg, ID_memread, ID_memwrite, ID_alusrc, ID_aluop;
    wire ID_regdist, ID_branchtype, ID_push, ID_pop, ID_ret, ID_jump;
	
    control control_cpu(
        .opcode(ID_instruction[18:14]),
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

	
    wire [18:0] wd;
    wire [18:0] ID_rd1, ID_rd2;
    wire [2:0] ws;
	

    reg_file reg_file_cpu(            //calling reg_file.v
        .clk(clk),
        .reset(1'b0),
        .WB_regwrite(WB_regwrite),
        .ID_push(ID_push),
        .ID_pop(ID_pop),
        .stack_pc(ID_pc_plus_one),
        .rs1(ID_instruction[13:11]),
        .rs2(ID_instruction[10:8]),
        .ws(ws),
        .wd(wd),
        .ID_rd1(ID_rd1),
        .ID_rd2(ID_rd2)
    );
	
	wire zero;
	
    comparator comparator_cpu(       //calling comparator.v
        .ID_rd1(ID_rd1),
        .ID_rd2(ID_rd2),
        .zero(zero)
    );
	
    wire zero_flag;
    assign zero_flag = (ID_branchtype) ? ~zero : zero;
    assign branch_signal = ID_branch && zero_flag;

    wire [7:0] branch_mux_pc;
    assign branch_mux_pc = (branch_signal) ? ID_instruction[7:0] : ID_pc_plus_one;

    wire [7:0] jump_mux_pc;
    assign jump_mux_pc = (ID_jump) ? ID_instruction[7:0] : branch_mux_pc;

    assign ret_mux_pc = (ID_ret) ? ID_rd1 : jump_mux_pc;

    wire EX_regwrite, EX_memtoreg, EX_memread, EX_memwrite, EX_alusrc, EX_aluop, EX_regdist;
    wire [7:0] EX_immediate;
    wire [2:0] EX_rs, EX_rt, EX_rd;
    wire [31:0] EX_rd1, EX_rd2;
    wire [4:0] EX_opcode;
	


    ID_EX ID_EX_cpu(                            //calling ID_EX.v
        .clk(clk),
        .ID_opcode(ID_instruction[18:14]),
        .ID_regwrite(ID_regwrite),
        .ID_memtoreg(ID_memtoreg),
        .ID_memread(ID_memread),
        .ID_memwrite(ID_memwrite),
        .ID_alusrc(ID_alusrc),
        .ID_aluop(ID_aluop),
        .ID_regdist(ID_regdist),
        .ID_immediate(ID_instruction[7:0]),
        .ID_rs(ID_instruction[13:11]),
        .ID_rt(ID_instruction[10:8]),
        .ID_rd(ID_instruction[7:5]),
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
    wire [1:0] sel1, sel2;
    wire [18:0] in1, EX_in2_mux, in2;

    wire [18:0] MEM_out;
    alu_mux alu_mux_in1(
        .sel(sel1),
        .EX_data(EX_rd1),
        .MEM_data(MEM_out),
        .WB_data(wd),
        .in(in1)
    );

    alu_mux alu_mux_in2(
        .sel(sel2),
        .EX_data(EX_rd2),
        .MEM_data(MEM_out),
        .WB_data(wd),
        .in(EX_in2_mux)
    );
	
    wire [18:0] extended_EX_immediate;
    assign extended_EX_immediate = { 24'b0, EX_immediate};
    assign in2 = (EX_alusrc) ? extended_EX_immediate : EX_in2_mux;

    wire [4:0] alu_ctrl;

    alu_control alu_control_cpu(
        .opcode(EX_opcode),
        .funct(EX_immediate[4:0]),
        .operation(alu_ctrl)
    );
 
	wire [18:0] EX_out;


    alu alu_cpu(                 //calling alu.v
        .in1(in1),
        .in2(in2),
        .alu_ctrl(alu_ctrl),
        .EX_out(EX_out)
    );

    wire [2:0] EX_rd_muxed;
    assign EX_rd_muxed = (EX_regdist) ? EX_rd : EX_rt;

    wire MEM_regwrite, MEM_memtoreg, MEM_memread, MEM_memwrite;
    wire [18:0] MEM_wdata;
    wire [2:0] MEM_rd;
 
   EX_MEM EX_MEM_cpu (                        //calling EX_MEM.v
        .clk(clk),
        .EX_regwrite(EX_regwrite),
        .EX_memtoreg(EX_memtoreg),
        .EX_memread(EX_memread),
        .EX_memwrite(EX_memwrite),
        .EX_out(EX_out),
        .EX_wdata(EX_in2_mux),
        .EX_rd(EX_rd_muxed),
        .MEM_regwrite(MEM_regwrite),
        .MEM_memtoreg(MEM_memtoreg),
        .MEM_memread(MEM_memread),
        .MEM_memwrite(MEM_memwrite),
        .MEM_out(MEM_out),
        .MEM_wdata(MEM_wdata),
        .MEM_rd(MEM_rd)
    );  

    wire [19:0] MEM_rdata;

    data_mem data_mem_cpu(              //calling dat_mem.v
        .clk(clk),
        .reset(reset),
        .MEM_memwrite(MEM_memwrite),
        .MEM_memread(MEM_memread),
        .addr(MEM_out[7:0]),
        .wdata(MEM_wdata),
        .rdata(MEM_rdata)
    );

    wire WB_memwrite, WB_memtoreg;
    wire [19:0] WB_rdata, WB_out;
    wire [2:0] WB_rd;

    MEM_WB MEM_WB_cpu(                           //calling MEM_WB.v
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

    assign ws = WB_rd;
    assign wd = (WB_memtoreg) ? WB_rdata : WB_out;

    forwarding_unit forwarding_unit_cpu(                      //calling forwarding_unit.v
        .EX_rs(EX_rs),
        .EX_rt(EX_rt),
        .MEM_rd(MEM_rd),
        .WB_rd(WB_rd),
        .MEM_regwrite(MEM_regwrite),
        .WB_regwrite(WB_regwrite),
        .mux_in1(sel1),
        .mux_in2(sel2)
    );

    hazard_detection hazard_detection_cpu(                    //calling hazard_detection.v
        .reset(reset),
        .EX_memread(EX_memread),
        .EX_rt(EX_rt),
        .ID_rs(ID_instruction[13:11]),
        .ID_rt(ID_instruction[10:8]),
        .hazard(hazard),
        .IF_IDwrite(IF_IDwrite),
        .PCwrite(pcwrite)
    );

    task print_reg_file;
        begin
          reg_file_cpu.print_register_values();
        end
    endtask

    task print_mem_file;
        begin
          data_mem_cpu.print_data_memory_values();
        end
    endtask

    always @(posedge clk ) begin
    
	end
	
endmodule
		
