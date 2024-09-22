module hazard_detection(
    input reset,
	input EX_memread,
	input [2:0] EX_rt,
	input [2:0] ID_rt,
	input [2:0] ID_rs,
	output reg hazard,
	output reg IF_IDwrite,
	output reg PCWrite
);
  
    always @ (*) begin
	    if (reset) begin
		    hazard = 1'b0;
		    IF_IDwrite = 1'b1;
		    PCWrite= 1'b1;
        end
		else if (EX_memread && ((EX_rt == ID_rt) || (EX_rt == ID_rs))) begin
		    hazard = 1'b1;
			IF_IDwrite = 1'b0;
			PCWrite= 1'b0;
		end 
		
	end 
	
endmodule