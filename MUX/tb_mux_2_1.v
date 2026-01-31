module tb_mux;
    reg sel,a,b;
    wire out;
    
    mux_2_1 uut(.sel(sel), .a(a), .b(b), .out(out));
    
    always #5 a= ~a;
    always #10 b= ~b;
    always #50 sel=~sel;
    
    initial begin
        a=0; b=0; sel=0;
        // Corrected spelling to $monitor
        $monitor("Time : %0t\t | A = %0b\t | B =%0b\t | output Y = %0b", $time, a, b, out);
        #400; // Added semicolon
        $finish; // Added semicolon
    end
endmodule
