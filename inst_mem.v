module inst_mem (
     input [7:0] pc, //input is 8 bit
	 output reg [18:0] instructions //output is 19 bit
);
     reg [18:0] memory [0:25];
	 initial begin
	 // Example--we paused video here for length of video to be short
	 //ADD
        memory[0] = 19'b0000000000101100000;
        // SUB r4, r1, r2
        memory[1] = 19'b0000001001001100001;
        // AND r5, r2, r3
        memory[2] = 19'b0000010001101100010;
        // OR r6, r3, r4
        memory[3] = 19'b0000011010001100011;
        // XOR r7, r4, r5
        memory[4] = 19'b0000100010101100100;
        // NOT r8, r5
        memory[5] = 19'b0000101011000000101;
        // ADDI r9, r6, 5
        memory[6] = 19'b0000110011101010110;
        // SUBI r10, r7, 3
        memory[7] = 19'b0000111100000110111;
        // ANDI r11, r8, 2
        memory[8] = 19'b0001000100100101000;
        // ORI r12, r9, 1
        memory[9] = 19'b0001001101000011001;
        // XORI r13, r10, 4
        memory[10] = 19'b0001010101101001010;
        // NOP (No operation)
        memory[11] = 19'b0000000000000000000;

        // Control flow instructions
        // JMP to address 50
        memory[12] = 19'b000101111000000110010;
        // BEQ r1, r2, address 60
        memory[13] = 19'b000110011010011011100;
        // BNE r3, r4, address 70
        memory[14] = 19'b000110111100100011110;

        // Memory access instructions
        // LOAD r14, address 80
        memory[15] = 19'b000111011110000101000;
        // STORE r15, address 90
        memory[16] = 19'b001000000000000101010;

        // Custom instructions
        // FFT r16, r17
        memory[17] = 19'b001000100010000101100;
        // DEC r18
        memory[18] = 19'b001001000100000101110;
        // ENC r19
        memory[19] = 19'b001001100110000110000;
	end
	
	always @(*) begin
	    instructions = memory[pc]; //pc is program Counter..we'll see it soon
	end
	
endmodule 
