//Now we'll move to reg file

module reg_file(
    input clk,
	input reset,
	input WB_regwrite,
	input ID_push,
	input ID_pop,
	input [7:0] stack_pc,
	input [2:0] rs1,
	input [2:0] rs2,
	input [2:0] ws,
	input [18:0] wd,
	output reg [18:0] ID_rd1,
	output reg [18:0] ID_rd2
);
    integer i;
	integer SP =7;
	reg [18:0] register_file[0:7];
	
	initial begin
        register_file[0] = 19'd0;
		register_file[1] = 19'd0;
		register_file[2] = 19'd0;
		register_file[3] = 19'd0;
		register_file[4] = 19'd0;
		register_file[5] = 19'd0;
		register_file[6] = 19'd0;
		register_file[7] = 19'd0;
	end
	
	always @(posedge clk or posedge reset or rs1 or rs2 or ws or wd) begin
	    ID_rd1 = register_file[rs1];
		ID_rd2 = register_file[rs2];
		
		
		if (reset) begin 
		    for (i=0;i<8;i=i+1) begin
			    register_file[i] = 19'd0;
			end
		end else begin
		    if(WB_regwrite) begin   
			    register_file[ws] =wd;
			end
			
			
			if(ID_push) begin  
			    register_file[SP] <= stack_pc;
				SP <= SP-1;
			end 
			if(ID_pop) begin  
			    SP = SP+1;
				ID_rd1 <= register_file[SP];
				register_file[SP] <= 19'd0;
			end
		end 
	end
	//Now we'll make our debugging convienent by following
	task print_regsiter_values;
	    integer i;
		begin 
		    $display ("register Values are:");
			for (i=0;i<8;i=i+1) begin
			    $display("Register %d is: %d", i,register_file[i]);
			end 
		end 
		
	endtask
	

endmodule