`timescale 1ns / 1ps

module tb_comparator_8bit();

    // Inputs
    reg [7:0] A;
    reg [7:0] B;

    // Outputs
    wire greater;
    wire equal;
    wire less;

    // Instantiate the Unit Under Test (UUT)
    comparator_8bit uut (
        .A(A),
        .B(B),
        .greater(greater),
        .equal(equal),
        .less(less)
    );

    initial begin
        // Display header
        $display("Time |  A  |  B  | G | E | L");
        $display("------------------------------");

        // Test 1: Equal values
        A = 8'd50; B = 8'd50;
        #10 $display("%4t | %3d | %3d | %b | %b | %b", $time, A, B, greater, equal, less);

        // Test 2: A is greater
        A = 8'd200; B = 8'd100;
        #10 $display("%4t | %3d | %3d | %b | %b | %b", $time, A, B, greater, equal, less);

        // Test 3: B is greater
        A = 8'd15; B = 8'd250;
        #10 $display("%4t | %3d | %3d | %b | %b | %b", $time, A, B, greater, equal, less);

        // Test 4: Boundary case (Zero and Max)
        A = 8'h00; B = 8'hFF;
        #10 $display("%4t | %3d | %3d | %b | %b | %b", $time, A, B, greater, equal, less);

        #10 $finish;
    end

endmodule
