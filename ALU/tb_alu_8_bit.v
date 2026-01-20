`timescale 1ns / 1ps

module tb_alu_8bit();

    // Inputs
    reg [7:0] A;
    reg [7:0] B;
    reg [1:0] sel;

    // Outputs
    wire [7:0] result;
    wire carry_out;

    // Instantiate the ALU
    alu_8bit uut (
        .A(A),
        .B(B),
        .sel(sel),
        .result(result),
        .carry_out(carry_out)
    );

    initial begin
        $display("Sel |  A  |  B  | Result | Carry");
        $display("--------------------------------");

        // Test Addition: 10 + 5 = 15
        A = 8'd10; B = 8'd5; sel = 2'b00;
        #10 $display(" %b | %3d | %3d |  %3d   |   %b", sel, A, B, result, carry_out);

        // Test Subtraction: 20 - 4 = 16
        A = 8'd20; B = 8'd4; sel = 2'b01;
        #10 $display(" %b | %3d | %3d |  %3d   |   %b", sel, A, B, result, carry_out);

        // Test AND: 8'b10101010 & 8'b11110000 = 8'b10100000
        A = 8'b10101010; B = 8'b11110000; sel = 2'b10;
        #10 $display(" %b | %b | %b | %b | %b", sel, A, B, result, carry_out);

        // Test OR: 8'b10101010 | 8'b11110000 = 8'b11111010
        A = 8'b10101010; B = 8'b11110000; sel = 2'b11;
        #10 $display(" %b | %b | %b | %b | %b", sel, A, B, result, carry_out);

        // Test Overflow/Carry: 255 + 1
        A = 8'd255; B = 8'd1; sel = 2'b00;
        #10 $display(" %b | %3d | %3d |  %3d   |   %b", sel, A, B, result, carry_out);

        #10 $finish;
    end

endmodule
