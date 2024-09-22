//now we'll see the testbench case of data_mem.v
 module tb_data_mem;
 
//inputs are:
    reg clk;
	reg reset;
	reg MEM_memwrite;
	reg MEM_memread;
	reg [7:0] addr;
	reg [18:0] wdata;
	//outputs:
	data_mem uut(
	    .clk(clk), //instantiate the units under test uuts
		.reset(reset),
		.MEM_memwrite(MEM_memwrite),
		.MEM_memread(MEM_memread),
		.addr(addr),
		.wdata(wdata),
		.rdata(rdata)
	);
	
	initial begin
	    //initialize inputs
		clk =0;
		reset =1;
		MEM_memwrite = 0;
		MEM_memread= 0;
		addr = 0;
		wdata= 0;
		#100; //waiting for global reset
		reset =0;
		
		//applying test vectors
		//Write data to memory
		MEM_memwrite =1;
		addr=8'h10;
		wdata = 19'h1A5A5;
		#20;
		MEM_memwrite =0;
		
		//Read data from memory
		MEM_memread =1;
		addr=8'h10;
		#20;
		MEM_memread =0;
		
		//Write and Read another data
		MEM_memwrite =1;
		addr=8'h20;
		wdata = 19'h1A5A5;
		#20;
		MEM_memwrite =0;
		
		MEM_memread = 1;
		addr=8'h20;
		#20;
		MEM_memread =0;
		 
		 
		$finish;
	end
	 
	always #10 clk = ~clk; //clock generation
endmodule