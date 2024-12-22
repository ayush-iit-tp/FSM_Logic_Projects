/*
This line declares a module named tb_traffic_light_controller, 
which serves as the testbench for the traffic_light_controller module.
*/
module tb_traffic_light_controller;
/*
reg clk, reset;: Declares two register variables for the clock signal (clk) 
and the reset signal (reset).
wire [2:0] light_NS, light_EW;: Declares two 3-bit wires for 
the North-South (light_NS) and East-West (light_EW) traffic lights.
*/
    reg clk;
    reg reset;
    wire [2:0] light_NS;
    wire [2:0] light_EW;

/*
This block instantiates the traffic_light_controller module 
with the instance name uut (unit under test).
The inputs clk and reset are connected to the corresponding inputs 
of the traffic_light_controller.
The outputs light_NS and light_EW are connected to the corresponding outputs 
of the traffic_light_controller.
*/
    traffic_light_controller uut (
        .clk(clk),
        .reset(reset),
        .light_NS(light_NS),
        .light_EW(light_EW)
    );

/*
initial begin ... end: This block starts executing at the beginning of the simulation.
The sequence of assignments and delays sets the values of the input signals clk 
and reset over time:
clk = 0;: Initializes the clock signal to 0.
reset = 1;: Asserts the reset signal at the start of the simulation.
#10;: Waits for 10 time units.
reset = 0;: Deasserts the reset signal after 10 time units.
$monitor("Time = %0d, light_NS = %b, light_EW = %b", $time, light_NS, light_EW);: 
Continuously monitors and prints the values of light_NS and light_EW along with 
the simulation time whenever any of these variables change.
#1000; $finish;: Runs the simulation for 1000 time units and then ends the simulation.
*/
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
/*
Summary
The testbench sets up a simple simulation environment to 
test the traffic_light_controller module.
It generates a periodic clock signal and initializes the reset signal.
It monitors the output traffic lights (light_NS and light_EW) over time.
The simulation runs for 1000 time units, allowing sufficient time 
to observe the state transitions of the traffic lights.
*/
