`timescale 1ns / 1ps

module tb_ripple_carry_adder();

    // Inputs (reg)
    reg [3:0] A;
    reg [3:0] B;
    reg cin;

    // Outputs (wire)
    wire [3:0] Sum;
    wire cout;

    // Instantiate the Unit Under Test (UUT)
    ripple_carry_adder_4bit uut (
        .A(A), 
        .B(B), 
        .cin(cin), 
        .Sum(Sum), 
        .cout(cout)
    );

    initial begin
        // Format the output display in the console
        $display("A    + B    + cin | Sum  cout");
        $display("---------------------------");
        
        // Test 1: 2 + 3
        A = 4'd2; B = 4'd3; cin = 0;
        #10;
        $display("%b + %b + %b   | %b  %b", A, B, cin, Sum, cout);

        // Test 2: 7 + 1 + (cin 1)
        A = 4'd7; B = 4'd1; cin = 1;
        #10;
        $display("%b + %b + %b   | %b  %b", A, B, cin, Sum, cout);

        // Test 3: 15 + 1 (Overflow case)
        A = 4'b1111; B = 4'b0001; cin = 0;
        #10;
        $display("%b + %b + %b   | %b  %b", A, B, cin, Sum, cout);

        // Test 4: 10 + 10
        A = 4'd10; B = 4'd10; cin = 0;
        #10;
        $display("%b + %b + %b   | %b  %b", A, B, cin, Sum, cout);

        #10 $finish;
    end

endmodule
