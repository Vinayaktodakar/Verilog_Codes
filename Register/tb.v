`timescale 1ns / 1ps

module tb_register_8bit();

    // Inputs
    reg clk;
    reg sync_rst;
    reg load;
    reg [7:0] data_in;

    // Outputs
    wire [7:0] data_out;

    // Instantiate the Unit Under Test (UUT)
    register_8bit uut (
        .clk(clk),
        .sync_rst(sync_rst),
        .load(load),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation: 10ns period (100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        sync_rst = 0;
        load = 0;
        data_in = 8'h00;

        $display("Time | RST | LOAD | DATA_IN | DATA_OUT");
        $display("---------------------------------------");

        // 1. Apply Reset
        @(posedge clk);
        sync_rst = 1;
        #10; // Wait one cycle
        $display("%4t |  %b  |  %b   |   %h    |    %h", $time, sync_rst, load, data_in, data_out);

        // 2. Release Reset and Load a value (0xAA)
        sync_rst = 0;
        load = 1;
        data_in = 8'hAA;
        #10;
        $display("%4t |  %b  |  %b   |   %h    |    %h", $time, sync_rst, load, data_in, data_out);

        // 3. Disable Load (Maintain current value even if input changes)
        load = 0;
        data_in = 8'hFF;
        #10;
        $display("%4t |  %b  |  %b   |   %h    |    %h", $time, sync_rst, load, data_in, data_out);

        // 4. Load a new value (0x55)
        load = 1;
        data_in = 8'h55;
        #10;
        $display("%4t |  %b  |  %b   |   %h    |    %h", $time, sync_rst, load, data_in, data_out);

        #10 $finish;
    end

endmodule
