//now we'll see the testbench of pc.v module
module tb_pc;
//inputs

    reg clk;
	reg reset;
	reg pcwrite;
	reg [18:0] next_pc;
	//outputs
	wire [18:0] pc;
	
	//Now we'll instantiate the UUTs
	pc uut(
	    .clk(clk),
		.reset(reset),
		.pcwrite(pcwrite),
		.next_pc(next_pc),
		.pc(pc)
	);
	
	
	initial begin
	//initializing inputs:
	    clk =0;
		reset =1;
		pcwrite =0;
		next_pc =19'b0;
		#100; //wait for global reset
		reset =0;
		
		//Now we'll apply test vectors
		//1:Write to pc
		pcwrite =1;
		next_pc =19'h10;
		#20;
		$display("PC: %h", pc);
		
		//2:Write to pc
		next_pc =19'h20;
		#20;
		$display("PC: %h", pc);
		
		//3:Reset pc
		reset =1;
		#20;
		reset =0;
		$display("PC after RESET: %h", pc);
		
		//4:Write to pc
		pcwrite =1;
		next_pc =19'h30;
		#20;
		$display("PC: %h", pc);
		
		$finish; //end simulation
	end
	always #10 clk = ~clk;
	
endmodule