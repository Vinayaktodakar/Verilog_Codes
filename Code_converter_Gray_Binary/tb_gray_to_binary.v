module tb_gray_to_binary;
    wire  [3:0] binary;
    reg [3:0] gray;

    gray_to_binary uut (
        .bin(binary),
        .gray(gray)
    );

    initial begin
        $monitor(" Gray: %b  |  Binary: %b ", gray, binary);
        
        gray = 4'b0000; #10; // Gray: 0000
        gray = 4'b0110; #10; // Gray: 0101
        gray = 4'b1000; #10; // Gray: 1100
        gray = 4'b1111; #10; // Gray: 1000
        $finish;
    end
endmodule
