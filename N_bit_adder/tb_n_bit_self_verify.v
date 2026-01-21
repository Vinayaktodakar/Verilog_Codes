`timescale 1ns / 1ps

module tb_n_bit_adder();
    // STEP 1: Define the width for this simulation run
    parameter WIDTH = 4; // You can change this to 4, 8, 32, etc.

    // Testbench signals
    reg [WIDTH-1:0] A, B;
    reg cin;
    wire [WIDTH-1:0] Sum;
    wire cout;
    
    // Internal variables for verification
    reg [WIDTH:0] expected_full_sum; 
    integer i;

    // STEP 2: Instantiate UUT with the parameter override
    n_bit_adder #(.N(WIDTH)) uut (
        .A(A),
        .B(B),
        .cin(cin),
        .Sum(Sum),
        .cout(cout)
    );

    initial begin
        $display("--- Testing %0d-bit Adder ---", WIDTH);
        $display("Time \t| A \t| B \t| cin \t| Result \t| Status");
        $display("-------------------------------------------------------");
        
        // Loop through several test cases
        for (i = 0; i < 10; i = i + 1) begin
            // Generate random inputs
            A = $urandom;
            B = $urandom;
            cin = $urandom % 2;

            #10; // Wait for combinational logic to settle

            // STEP 3: Verification logic (Golden Model)
            // We concatenate cout and Sum to compare against the full mathematical result
            expected_full_sum = A + B + cin;

            if ({cout, Sum} == expected_full_sum) begin
                $display("%4t \t| %0d \t| %0d \t| %b \t| %0d \t| PASS\t", $time, A, B, cin, Sum);
            end else begin
                $display("%4t | %0d | %0d | %b | %0d | FAIL (Expected %0d)", 
                          $time, A, B, cin, {cout, Sum}, expected_full_sum);
            end
        end

        $display("--- Test Completed ---");
        $finish;
    end
endmodule
