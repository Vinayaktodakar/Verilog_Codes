module traffic_light_fsm (
    input  clk,
    input  reset,
    output reg [2:0] lights // [Red, Yellow, Green] bits
);

    // State encoding
    parameter GREEN  = 2'b00, 
              YELLOW = 2'b01, 
              RED    = 2'b10;

    // Timing parameters (cycles)
    parameter T_GREEN  = 32'd10, // Example: 10 cycles
              T_YELLOW = 32'd3,  // Example: 3 cycles
              T_RED    = 32'd15; // Example: 15 cycles

    reg [1:0]  state, next_state;
    reg [31:0] count;

    // Block 1: State register and timer logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= GREEN;
            count <= 32'd0;
        end else begin
            case (state)
                GREEN:  if (count < T_GREEN)  count <= count + 1; else begin count <= 0; state <= YELLOW; end
                YELLOW: if (count < T_YELLOW) count <= count + 1; else begin count <= 0; state <= RED;    end
                RED:    if (count < T_RED)    count <= count + 1; else begin count <= 0; state <= GREEN;  end
                default: state <= GREEN;
            endcase
        end
    end

    // Block 2: Output decoding
    always @(*) begin
        case (state)
            GREEN:  lights = 3'b001; // Green ON
            YELLOW: lights = 3'b010; // Yellow ON
            RED:    lights = 3'b100; // Red ON
            default: lights = 3'b100;
        endcase
    end

endmodule
