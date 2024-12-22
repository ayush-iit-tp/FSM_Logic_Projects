/*This line declares a module named traffic_light_controller.
It has two inputs:
clk: The clock signal.
reset: The reset signal.
It has two 3-bit output registers:
light_NS: The traffic light for the North-South direction.
light_EW: The traffic light for the East-West direction.
*/
module traffic_light_controller(
    input clk,            // Clock input
    input reset,          // Reset input
    output reg [2:0] light_NS, // North-South traffic light (3 bits: Red, Yellow, Green)
    output reg [2:0] light_EW  // East-West traffic light (3 bits: Red, Yellow, Green)
);
/*
This block defines an enumerated type state_t for the state machine with four states:
NS_GREEN_EW_RED: North-South green, East-West red.
NS_YELLOW_EW_RED: North-South yellow, East-West red.
NS_RED_EW_GREEN: North-South red, East-West green.
NS_RED_EW_YELLOW: North-South red, East-West yellow.
state and next_state are declared as variables of type state_t.
counter is a 32-bit register used to count clock cycles for timing.
*/
    // State encoding
    typedef enum reg [1:0] {
        NS_GREEN_EW_RED = 2'b00,
        NS_YELLOW_EW_RED = 2'b01,
        NS_RED_EW_GREEN = 2'b10,
        NS_RED_EW_YELLOW = 2'b11
    } state_t;

/*
The state_t concept in your Verilog code is an example of an enumerated type, 
which is a user-defined data type that consists of a set of named values called enumerators.
In Verilog, enumerated types are used to make state machines and other code more readable and maintainable.
*/
    
    state_t state, next_state;
    reg [31:0] counter; // Counter for timing
    
/*
This always block is sensitive to the positive edge of the clock and the reset signal.
If the reset signal is asserted, the state is set to NS_GREEN_EW_RED and the counter is reset to 0.
Otherwise, the counter increments on each clock cycle.
When the counter reaches 100, the state transitions to next_state, and the counter is reset to 0.
*/
    // State transition and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= NS_GREEN_EW_RED;
            counter <= 0;
        end else begin
            counter <= counter + 1;
            if (counter == 100) begin // Change state every 100 clock cycles
                state <= next_state;
                counter <= 0;
            end
        end
    end

/*
This always block determines the next_state and sets the output lights based on the current state.
The case statement handles each possible state:
NS_GREEN_EW_RED: Sets the North-South light to green and the East-West light to red. Transitions to NS_YELLOW_EW_RED.
NS_YELLOW_EW_RED: Sets the North-South light to yellow and the East-West light to red. Transitions to NS_RED_EW_GREEN.
NS_RED_EW_GREEN: Sets the North-South light to red and the East-West light to green. Transitions to NS_RED_EW_YELLOW.
NS_RED_EW_YELLOW: Sets the North-South light to red and the East-West light to yellow. Transitions to NS_GREEN_EW_RED.
default: Sets both lights to red and transitions to NS_GREEN_EW_RED.
*/    
    // Next state logic
    always @(*) begin
        case (state)
            NS_GREEN_EW_RED: begin
                light_NS = 3'b001; // Green
                light_EW = 3'b100; // Red
                next_state = NS_YELLOW_EW_RED;
            end
            NS_YELLOW_EW_RED: begin
                light_NS = 3'b010; // Yellow
                light_EW = 3'b100; // Red
                next_state = NS_RED_EW_GREEN;
            end
            NS_RED_EW_GREEN: begin
                light_NS = 3'b100; // Red
                light_EW = 3'b001; // Green
                next_state = NS_RED_EW_YELLOW;
            end
            NS_RED_EW_YELLOW: begin
                light_NS = 3'b100; // Red
                light_EW = 3'b010; // Yellow
                next_state = NS_GREEN_EW_RED;
            end
            default: begin
                light_NS = 3'b100; // Red
                light_EW = 3'b100; // Red
                next_state = NS_GREEN_EW_RED;
            end
        endcase
    end
endmodule
/*
Summary
The module implements a simple traffic light controller using a finite state machine.
It cycles through four states, controlling the traffic lights for a North-South and East-West intersection.
The state transitions occur every 100 clock cycles, simulating the timing of traffic light changes.
The lights are represented using 3-bit values where each bit corresponds to Red, Yellow, and Green lights respectively.
*/
