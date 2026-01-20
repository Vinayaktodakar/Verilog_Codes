module comparator_8bit (
    input  [7:0] A,        // 8-bit input operand A
    input  [7:0] B,        // 8-bit input operand B
    output       greater,  // High if A > B
    output       equal,    // High if A == B
    output       less      // High if A < B
);

    // Continuous assignments using relational operators
    assign greater = (A > B);
    assign equal   = (A == B);
    assign less    = (A < B);

endmodule
