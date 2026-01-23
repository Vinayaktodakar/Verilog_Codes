module binary_to_gray (
    input  [3:0] binary, // 4-bit binary input
    output [3:0] gray    // 4-bit Gray code output
);

    // The Gray code MSB is always equal to the binary MSB
    // Each subsequent bit is binary[n] XOR binary[n+1]
    assign gray[3] = binary[3];
    assign gray[2] = binary[3] ^ binary[2];
    assign gray[1] = binary[2] ^ binary[1];
    assign gray[0] = binary[1] ^ binary[0];

    /* 
       Alternative bitwise concatenation:
       assign gray = (binary >> 1) ^ binary; 
    */

endmodule
