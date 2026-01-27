module tb_seq_1101;
    reg clk,in,rst;
    wire out;
    
    seq_det uut(.clk(clk), .in(in), .rst(rst), .out(out));
    
    always #5 clk =~clk;
    
    initial begin
        // Initialize and Reset
        clk=0;
        in = 0;
        rst = 1;
        #20 rst = 0;

        // Apply bit stream: 10110 (Sequence 1)
        apply_bit(1); apply_bit(0); apply_bit(1); apply_bit(1); apply_bit(0);
        
    
        // Bit stream: 10110110
        apply_bit(1); apply_bit(1); apply_bit(0); 

        // False pattern test: 10101
      apply_bit(1); apply_bit(0); apply_bit(1); apply_bit(0); apply_bit(1); apply_bit(0); apply_bit(1); apply_bit(1);  apply_bit(0);
      

        #100 $finish;
    end

    // Helper task to apply data synchronized to clock
    task apply_bit(input i);
        begin
            @(negedge clk);
            in = i;
        end
    endtask

    // 3. Monitoring
    initial begin
        $monitor("Time=%0t | Reset=%b | Input=%b | Output=%b", $time, rst, in, out);
        // Optional: Generate waveform file
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_seq_10110);
    end

endmodule
