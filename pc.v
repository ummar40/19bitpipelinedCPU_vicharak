//we'll continue our journey with pc.v module now
module pc(
    input clk,
	input reset,
	input pcwrite,
	input [18:0] next_pc,
	output reg [18:0] pc
);  
    always @ (posedge clk or posedge reset) begin
	    if (reset) begin
		    pc = 19'b0;
		end
		else if (pcwrite) begin
		    pc = next_pc;
		end
	end 
	
	
endmodule