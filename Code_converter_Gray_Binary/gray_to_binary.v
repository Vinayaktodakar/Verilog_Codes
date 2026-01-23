module gray_to_binary (
    input  [3:0] gray,   // 4-bit Gray code input
    output reg [3:0] bin // 4-bit Binary output (declared as reg for procedural assignment)
);

    always @(*) begin
        // The binary MSB is equal to the Gray MSB
        bin[3] = gray[3];
        
        // Each subsequent binary bit is the XOR of the 
        // current Gray bit and the previous binary bit
        bin[2] = bin[3] ^ gray[2];
        bin[1] = bin[2] ^ gray[1];
        bin[0] = bin[1] ^ gray[0];
    end

endmodule
