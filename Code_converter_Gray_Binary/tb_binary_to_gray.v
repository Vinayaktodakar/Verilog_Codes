module tb_binary_to_gray;
    reg  [3:0] binary;
    wire [3:0] gray;

    binary_to_gray uut (
        .binary(binary),
        .gray(gray)
    );

    initial begin
        $monitor("Binary: %b | Gray: %b", binary, gray);
        
        binary = 4'b0000; #10; // Gray: 0000
        binary = 4'b0110; #10; // Gray: 0101
        binary = 4'b1000; #10; // Gray: 1100
        binary = 4'b1111; #10; // Gray: 1000
        $finish;
    end
endmodule
