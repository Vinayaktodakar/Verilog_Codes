`timescale 1ns / 1ps

module tb_decoder_3to8();

    // Inputs
    reg [2:0] in;
    reg enable;

    // Outputs
    wire [7:0] out;

    // Instantiate the Unit Under Test (UUT)
    decoder_3to8 uut (
        .in(in),
        .enable(enable),
        .out(out)
    );

    initial begin
        // Display header
        $display("EN | IN | Output (76543210)");
        $display("--------------------------");

        // Test Case 1: Disabled state
        enable = 0; in = 3'b000;
        #10 $display("%b  | %b| %b", enable, in, out);

        // Test Case 2: Enabled state - Cycle through all inputs
        enable = 1;
        in = 3'b000; #10 $display("%b  | %b| %b", enable, in, out);
        in = 3'b001; #10 $display("%b  | %b| %b", enable, in, out);
        in = 3'b010; #10 $display("%b  | %b| %b", enable, in, out);
        in = 3'b011; #10 $display("%b  | %b| %b", enable, in, out);
        in = 3'b100; #10 $display("%b  | %b| %b", enable, in, out);
        in = 3'b101; #10 $display("%b  | %b| %b", enable, in, out);
        in = 3'b110; #10 $display("%b  | %b| %b", enable, in, out);
        in = 3'b111; #10 $display("%b  | %b| %b", enable, in, out);

        #10 $finish;
    end

endmodule
