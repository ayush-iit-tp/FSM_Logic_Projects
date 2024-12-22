module moore_1010_non_overlapping (
    input wire clk,    // Clock signal
    input wire rst,    // Reset signal
    input wire in,     // Input bit stream
    output reg out     // Output signal
);

    // Define states using an enumeration
    typedef enum reg [2:0] {
        S0, S1, S2, S3, S4  // State encoding
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

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: if (in) next_state = S1; else next_state = S0;
            S1: if (in) next_state = S1; else next_state = S2;
            S2: if (in) next_state = S3; else next_state = S0;
            S3: if (in) next_state = S4; else next_state = S0;
            S4: if (in) next_state = S1; else next_state = S0;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out <= 0;
        end else begin
            case (next_state)
                S4: out <= 1;
                default: out <= 0;
            endcase
        end
    end

endmodule
