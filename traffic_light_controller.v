module traffic_light_controller(
    input clk,            // Clock input
    input reset,          // Reset input
    output reg [2:0] light_NS, // North-South traffic light (3 bits: Red, Yellow, Green)
    output reg [2:0] light_EW  // East-West traffic light (3 bits: Red, Yellow, Green)
);

    // State encoding
    typedef enum reg [1:0] {
        NS_GREEN_EW_RED = 2'b00,
        NS_YELLOW_EW_RED = 2'b01,
        NS_RED_EW_GREEN = 2'b10,
        NS_RED_EW_YELLOW = 2'b11
    } state_t;

    state_t state, next_state;
    reg [31:0] counter; // Counter for timing

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
