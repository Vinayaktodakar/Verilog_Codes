module tb_seq_10110;
    reg clk,in,rst;
    wire out;
    
    seq_det_10110 uut(.clk(clk), .in(in), .rst(rst), .out(out));
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        in  = 0;
        rst = 1;
        #20 rst = 0;

        apply_bit(1); 
        apply_bit(0); 
        apply_bit(1); 
        apply_bit(1); 
        apply_bit(0);
        
        apply_bit(1); 
        apply_bit(1); 
        apply_bit(0); 

        apply_bit(1); 
        apply_bit(0); 
        apply_bit(1); 
        apply_bit(0); 
        apply_bit(1);

        #100 $finish;
    end

    task apply_bit(input i);
        begin
            @(negedge clk);
            in = i;
        end
    endtask

    initial begin
        $monitor("Time=%0t | Reset=%b | Input=%b | Output=%b", $time, rst, in, out);
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_seq_10110);
    end

endmodule
