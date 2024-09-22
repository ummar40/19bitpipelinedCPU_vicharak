//Now testbench case of reg_file.v module
module tb_reg_file;

    //Inputs are:
	reg clk;
	reg reset;
	reg WB_regwrite;
	reg ID_push;
	reg ID_pop;
	reg [7:0] stack_pc;
	reg [2:0] rs1;
	reg [2:0] rs2;
	reg [2:0] ws;
	reg [18:0] wd;
	
	//Output are:
	wire [18:0] ID_rd1;
	wire [18:0] ID_rd2;
	
	//instantiation of UUTs
	reg_file uut(
	    .clk(clk),
		.reset(reset),
		.WB_regwrite(WB_regwrite),
		.ID_push(ID_push),
		.ID_pop(ID_pop),
		.stack_pc(stack_pc),
		.rs1(rs1),
		.rs2(rs2),
		.ws(ws),
		.wd(wd),
		.ID_rd1(ID_rd1),
		.ID_rd2(ID_rd2)
		
    );
	
	initial begin
	
	//input initialization
	    clk=0;
		reset=1;
		WB_regwrite= 0;
		ID_push= 0;
		ID_pop= 0;
		stack_pc= 8'b0;
		rs1 = 3'b0;
		rs2 = 3'b0;
		ws = 3'b0;
		wd =19'b0;
		#100; 
		reset =0;
		//Test Vectors:
		//1:Write to register
		WB_regwrite= 1;
		ws = 3'b001;
		wd = 19'h1A5A5;
		#20;
		WB_regwrite =0;
		$display("Register 1: %h",uut.register_file[1]);
		
		//2:Read fro,m register
		rs1 =3'b001;
		#20;
		$display ("ID_rd1 : %h", ID_rd1);
		
		//3: Push to stack
		ID_push= 1;
		stack_pc= 8'h10;
		#20;
		ID_push =0;
		$display ("Stack Pointer : %d, Stack value: %h", uut.SP, uut.register_file[uut.SP +1]);
		
		//4:pop from stack
		ID_pop =1;
		#20;
		ID_pop =0;
		$display ("Stack pointer :%d, Stack value: %h", uut.Sp, ID_rd1);
		
		$finish; //finish simulation
	end
	always #10 clk = ~clk ; //clock generation
	
endmodule
		
		
		
		