module tb_alu_mux;

    // Inputs
    reg [1:0] sel;
    reg [18:0] EX_data;
    reg [18:0] MEM_data;
    reg [18:0] WB_data;

    // Outputs
    wire [18:0] in;

    // Instantiate the Unit Under Test (UUT)
    alu_mux uut (
        .sel(sel),
        .EX_data(EX_data),
        .MEM_data(MEM_data),
        .WB_data(WB_data),
        .in(in)
    );

    initial begin
        // Initialize Inputs
        sel = 0;
        EX_data = 19'h1A5A5;
        MEM_data = 19'h15A5A;
        WB_data = 19'h7FFFF;

        // Wait for global reset
        #100;

        // Apply test vectors
        sel = 2'b00;
        #20;

        sel = 2'b01;
        #20;

        sel = 2'b10;
        #20;

        // Finish simulation
        $finish;
    end

endmodule
