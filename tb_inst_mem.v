//now we'll write testbench of inst_mem.v file because keeping testbench for every file will be helpful
module tb_inst_mem;
//inputs are:
    reg [7:0] pc;
//outputs
    wire [18:0] instructions; //this will be clear from the architecture of our pipelined cpu
  
    inst_mem uut(
         .pc(pc), //i.e connect pc of stage 1 to pc of next stage
         .instruction(instruction)
    );
   
    initial begin

        pc = 0; //initializing inputs as PC=0	
		#100; //waiting for global reset
		//Applaying test vectors
		pc= 8'h00;
		#20;
		$display("Instruction at PC = 0: %b", instruction);
		
		pc = 8'h001;
		$display("Instruction at PC = 1: %b", instruction);
		pc = 8'h002;
		$display("Instruction at PC = 2: %b", instruction); //and so on
		
		$finish; //finishing simulation
	end
	
endmodule