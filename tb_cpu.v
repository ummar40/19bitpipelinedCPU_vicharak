//now we'll write most important testbench of cpu.v which will be used for simulation
module tb_cpu;
    //here are inputs
	reg clk;
	reg reset;
	  
	//now we'll instantiate the Unit Under Test UUT:
	cpu uut(
	    .clk(clk),
		.reset(reset)
	);
	
	initial begin
	
	    //input initialization:
		clk =0;
		reset =1;
		 
		#100; //waiting for global reset\
		reset =0;
		
		//we'll wait few clock cycles to process our instructions:
		#200; //this is time in ns
		
		//now we'll check outputs at different clock cyles
		//Like checking values of PC
		$display ("PC at cycle 1: %d"< uut.pc_cpu.pc);
		#20;
        $display ("PC at cycle 2: %d"< uut.pc_cpu.pc);
		#20;
		$display ("PC at cycle 3: %d"< uut.pc_cpu.pc);
		#20;
		
		//wait for few more cycles
		#500;
		
		$finish;  //finish simulation
	end
	
	always #10 clk = ~clk;

endmodule	
	
	
/*now we should be able to compile and simulate all our modules in ModelSim software.
TIPS:
>>keeping all our modules and test_benches in a same directory
>>We will start compiling the individual modules in following order:
----inst_mem.v >> data_mem.v >> pc.v >> reg_file.v >> forwarding_unit.v >> hazard_detection.v >> cpu.v and then in same order their testbenches. */
