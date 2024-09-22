//testnech oh hazard_detection.v
module tb_hazard_detection;
    //inputs are:
	reg reset;
	reg EX_memread;
	reg [2:0] EX_rt;
	reg [2:0] ID_rt;
	reg [2:0] ID_rs;
	reg clk;
	
	//outputs are:
	wire hazard;
	wire IF_IDwrite;
	wire PCWrite;
	
	//instantiation of UUTs
	hazard_detection uut(
	    .reset(reset),
		.EX_memread(EX_memread),
		.EX_rt(EX_rt),
		.ID_rt(ID_rt),
		.ID_rs(ID_rs),
		.hazard(hazard),
		.IF_IDwrite(IF_IDwrite),
		.PCWrite(PCWrite)
	);
	initial begin
	//initialize inputs:
	    reset =1;
		EX_memread= 0;
		EX_rt = 3'b000;
		ID_rt = 3'b000;
		ID_rs = 3'b000;
		
		#100;
		reset =0;
		
		//TEST VECTOTS:
		//1: NO hazard
		EX_memread =0;
		EX_rt = 3'b001;
		ID_rt = 3'b010;
		ID_rs = 3'b011;
		#20;
		$display ("Hazard: %b , IF_IDwrite: %b, PCWrite: %b", hazard, IF_IDwrite, PCWrite);
		
		//2: Hazard detected
		EX_memread =1;
		EX_rt = 3'b010;
		ID_rt = 3'b010;
		ID_rs = 3'b011;
		#20;
		$display ("Hazard: %b , IF_IDwrite: %b, PCWrite: %b", hazard, IF_IDwrite, PCWrite);
		
		//3: Hazard detected
		EX_memread =1;
		EX_rt = 3'b011;
		ID_rt = 3'b010;
		ID_rs = 3'b011;
		#20;
		$display ("Hazard: %b , IF_IDwrite: %b, PCWrite: %b", hazard, IF_IDwrite, PCWrite);
		
		//4: No hazard
		EX_memread =0;
		EX_rt = 3'b100;
		ID_rt = 3'b010;
		ID_rs = 3'b011;
		#20;
		$display ("Hazard: %b , IF_IDwrite: %b, PCWrite: %b", hazard, IF_IDwrite, PCWrite);
		
		//finish simulation
		$finish;
	end
	
	//clock generation
	always #10 clk = ~clk;
endmodule

/*Now we will write a module for CPU directly as we've other modules availble aslo necessary for the compilation and simultion like:
alu.v and tb_alu.v
alu_control.v and tb_alu_control.v
alu_mux and tb_alu_mux.v
comparator.v and tb_comparator.v
EX_MEM.v and tb_EX_MEM.v
IF_ID.v and tb_IF_ID.v
MEM_WB.v and tb_MEM_WB.v
TD_EX.v and tb_TD_EX.v and others*/

