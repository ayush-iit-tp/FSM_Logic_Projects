`timescale 1ns / 1ps

module tb_moore_1010_overlapping;

    reg clk;
    reg rst;
    reg in;
    wire out;

    // Instantiate the sequence detector
    moore_1010_overlapping uut (
        .clk(clk),
        .rst(rst),
        .in(in),
        .out(out)
    );

    // Clock generation
    always #5 clk = ~clk;  // Toggle clock every 5ns

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        in = 0;

        // Apply reset
        #10;
        rst = 0;

        // Test sequence: 10101010 (should detect two overlapping patterns)
        #10 in = 1;
        #10 in = 0;
        #10 in = 1;
        #10 in = 0;
        #10 in = 1;
        #10 in = 0;
        #10 in = 1;
        #10 in = 0;
        #10 in = 1;
        
        // Finish simulation
        #10;
        $stop;
    end

endmodule
