module forwarding_unit (
    input [2:0] EX_rs,
	input [2:0] EX_rt,
	input [2:0] MEM_rd,
	input [2:0] WB_rd,
	input MEM_regwrite,
	input WB_regwrite,
	output reg [1:0] mux_in1,
	output reg [1:0] mux_in2
);
    always @ (*) begin
	    mux_in1 = 2'b00;
		mux_in2 = 2'b00;
		
		if ((MEM_rd == EX_rs) && (MEM_regwrite)) begin
		    mux_in1 =2'b01;
		end
		
		if ((MEM_rd == EX_rt) && (MEM_regwrite)) begin
		    mux_in2 =2'b01;
		end
		
		if (((WB_rd == EX_rs) && (WB_regwrite)) && ~((MEM_rd == EX_rs) && (MEM_regwrite))) begin
            mux_in1 = 2'b10;
        end
		
		if (((WB_rd == EX_rt) && (WB_regwrite)) && ~((MEM_rd == EX_rt) && (MEM_regwrite))) begin
            mux_in2 = 2'b10;
        end
	end 
	
endmodule
		