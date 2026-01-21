`timescale 1ns / 1ps

module tb_register_bank();

    // Inputs
    reg clk;
    reg reset;
    reg we;
    reg [2:0] read_addr;
    reg [2:0] write_addr;
    reg [7:0] data_in;

    // Output
    wire [7:0] data_out;

    // Instantiate the UUT
    register_bank_8x8 uut (
        .clk(clk),
        .reset(reset),
        .we(we),
        .read_addr(read_addr),
        .write_addr(write_addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin
        $display("Time | Action          | W Addr | Data In | R Addr | Data Out");
        $display("---------------------------------------------------------------");

        // Initialization/Reset
        clk = 0; reset = 1; we = 0;
        #10 reset = 0; // Release reset

        // 1. Write 0xAA to Register 0
        @(posedge clk);
        we = 1; write_addr = 3'd0; data_in = 8'hAA;
        #1 $display("%4t | Write R[0]=0xAA |   %d    |   %h    |   %d    |   %h", $time, write_addr, data_in, read_addr, data_out);

        // 2. Write 0x55 to Register 4
        @(posedge clk);
        write_addr = 3'd4; data_in = 8'h55;
        #1 $display("%4t | Write R[4]=0x55 |   %d    |   %h    |   %d    |   %h", $time, write_addr, data_in, read_addr, data_out);

        // Stop writing
        @(posedge clk);
        we = 0;
        
        // 3. Read back Register 0 (Verify 0xAA)
        @(posedge clk);
        read_addr = 3'd0;
        #1 $display("%4t | Read R[0]       |   %d    |   %h    |   %d    |   %h", $time, write_addr, data_in, read_addr, data_out);

        // 4. Read Register 4 (Verify 0x55)
        @(posedge clk);
        read_addr = 3'd4;
        #1 $display("%4t | Read R[4]       |   %d    |   %h    |   %d    |   %h", $time, write_addr, data_in, read_addr, data_out);
        
        #20 $finish;
    end
endmodule
