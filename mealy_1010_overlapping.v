module mealy_1010_overlapping (
    input wire clk,    // Clock signal
    input wire rst,    // Reset signal
    input wire in,     // Input bit stream
    output reg out     // Output signal
);

    // Define states using an enumeration
    typedef enum reg [2:0] {
        S0, S1, S2, S3  // State encoding
    } state_t;

    state_t current_state, next_state;

    // State transition on clock edge or reset
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= S0;  // Reset to initial state
            out <= 0;              // Reset output
        end else begin
            current_state <= next_state;  // Move to next state
        end
    end

    // Next state logic and output logic
    always @(*) begin
        case (current_state)
            S0: begin
                if (in) begin
                    next_state = S1;  // Move to state S1 if input is 1
                    out = 0;          // Output remains 0
                end else begin
                    next_state = S0;  // Stay in state S0 if input is 0
                    out = 0;          // Output remains 0
                end
            end
            S1: begin
                if (in) begin
                    next_state = S1;  // Stay in state S1 if input is 1
                    out = 0;          // Output remains 0
                end else begin
                    next_state = S2;  // Move to state S2 if input is 0
                    out = 0;          // Output remains 0
                end
            end
            S2: begin
                if (in) begin
                    next_state = S3;  // Move to state S3 if input is 1
                    out = 0;          // Output remains 0
                end else begin
                    next_state = S0;  // Go back to state S0 if input is 0
                    out = 0;          // Output remains 0
                end
            end
            S3: begin
                if (in) begin
                    next_state = S1;  // Move to state S1 if input is 1
                    out = 1;          // Output becomes 1 (sequence detected)
                end else begin
                    next_state = S2;  // Move to state S2 if input is 0
                    out = 0;          // Output remains 0
                end
            end
            default: begin
                next_state = S0;  // Default state
                out = 0;          // Default output
            end
        endcase
    end

endmodule
