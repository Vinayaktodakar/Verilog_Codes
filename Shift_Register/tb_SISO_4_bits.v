`timescale 1ns / 1ps

module tb_shift_reg_siso();

    // Inputs
    reg clk;
    reg reset;
    reg si;

    // Output
    wire so;

    // Instantiate UUT
    shift_reg_siso uut (
        .clk(clk),
        .reset(reset),
        .si(si),
        .so(so)
    );

    // 100MHz clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0; reset = 1; si = 0;
        
        $display("Time | Reset | SI | SO (Output after 4 cycles)");
        $display("--------------------------------------------");

        #15 reset = 0; // Release reset

        // Input sequence: 1 -> 0 -> 1 -> 1
        @(posedge clk); si = 1; #1; $display("%4t |   %b   | %b  | %b", $time, reset, si, so);
        @(posedge clk); si = 0; #1; $display("%4t |   %b   | %b  | %b", $time, reset, si, so);
        @(posedge clk); si = 1; #1; $display("%4t |   %b   | %b  | %b", $time, reset, si, so);
        @(posedge clk); si = 1; #1; $display("%4t |   %b   | %b  | %b", $time, reset, si, so);

        // Feed zeros and watch the '1' from the first cycle finally appear at SO
        repeat (4) begin
            @(posedge clk); si = 0; 
            #1; $display("%4t |   %b   | %b  | %b", $time, reset, si, so);
        end

        #20 $finish;
    end

endmodule
