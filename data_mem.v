module data_mem(
    input clk,
	input reset,
	input MEM_memwrite, //memory write
	input MEM_memread, //memory read
	input [7:0] addr,
	input [18:0] wdata,
	output reg [18:0] rdata
);
    integer i =0;
	reg[18:0] memory [0:225];
	 
	always @ (posedge clk or posedge reset) begin
	 
	    if (reset) begin
		    for (i=0;i<256;i=i+1) begin 
		       memory[i] = 19'd0;
		    end
		end
		else if (MEM_memread) begin 
		    rdata = memory[addr];
		end
		else if (MEM_memwrite) begin
		    memory[addr] = wdata;
		end
	end
	
	task print_data_memory_values;
	    integer i;
		begin 
		    $display ("Memory values :");
			for (i =0;i<256;i=i+1) begin  
			    $display ("Memory %d = %d", i,memory[i]);
			end
		end
	endtask
endmodule
		