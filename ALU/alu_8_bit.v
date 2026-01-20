module alu_8bit (
    input  [7:0] A,          // Input operand A
    input  [7:0] B,          // Input operand B
    input  [1:0] sel,        // Operation select: 00:Add, 01:Sub, 10:AND, 11:OR
    output reg [7:0] result, // ALU result
    output reg carry_out     // Carry bit for addition/subtraction
);

    always @(*) begin
        // Initialize carry_out to 0 by default
        carry_out = 1'b0;
        
        case (sel)
            2'b00: begin // Addition
                {carry_out, result} = A + B;
            end
            2'b01: begin // Subtraction
                {carry_out, result} = A - B;
            end
            2'b10: begin // Bitwise AND
                result = A & B;
            end
            2'b11: begin // Bitwise OR
                result = A | B;
            end
            default: begin
                result = 8'h00;
                carry_out = 1'b0;
            end
        endcase
    end

endmodule
