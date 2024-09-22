//Testbench of forwarding_unit.v

module _tb_forwarding_unit;
    //inputs:
	reg [2:0] EX_rs;
	reg [2:0] EX_rt;
	reg [2:0] MEM_rd;
	reg [2:0] WB_rd;
	reg MEM_regwrite;
	reg WB_regwrite; 
	reg clk;
	
	//outputs
	wire [1:0] mux_in1;
	wire  [1:0] mux_in2;
	
	//now instantiation of UUTs
	forwarding_unit uut(
	    .EX_rs(EX_rs),
		.EX_rt(EX_rt),
		.MEM_rd(MEM_rd),
		.WB_rd(WB_rd),
		.MEM_regwrite(MEM_regwrite),
		.WB_regwrite(WB_regwrite),
		.mux_in1(mux_in1),
		.mux_in2(mux_in2)
	);
	
	initial begin
	    //initialization of inputs
		EX_rs=3'b000;
		EX_rt = 3'b000;
		MEM_rd= 3'b000;
		WB_rd = 3'b000;
		MEM_regwrite = 0;
		WB_regwrite =0;
		#20; 
		//TEST VECTORS:
		//1:
		MEM_rd = 3'b001;
		MEM_regwrite= 1;
		EX_rs = 3'b001;
		#20;
		$display("mux_in1: %b , mux_in2: %b", mux_in1, mux_in2);
		//2:
		MEM_rd = 3'b010;
		EX_rt = 3'b010;
		#20;
		$display("mux_in1: %b , mux_in2: %b", mux_in1, mux_in2);
		//3:
		MEM_rd = 3'b011;
		MEM_regwrite= 1;
		EX_rs = 3'b011;
		MEM_rd = 3'b000;
		MEM_regwrite= 0;
		#20;
		$display("mux_in1: %b , mux_in2: %b", mux_in1, mux_in2);
		
		
		$finish; //finish simulation
	end 
	
	always #10 clk = ~clk; //generating clock
endmodule
