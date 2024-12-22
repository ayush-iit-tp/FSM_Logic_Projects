module tb_traffic_light_controller;

    reg clk;
    reg reset;
    wire [2:0] light_NS;
    wire [2:0] light_EW;

    // Instantiate the traffic light controller
    traffic_light_controller uut (
        .clk(clk),
        .reset(reset),
        .light_NS(light_NS),
        .light_EW(light_EW)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // Toggle clock every 5 time units
    end

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;

        // Apply reset
        #10;
        reset = 0;

        // Monitor the outputs
        $monitor("Time = %0d, light_NS = %b, light_EW = %b", $time, light_NS, light_EW);

        // Run simulation for 1000 time units
        #1000;
        $finish;
    end
endmodule
