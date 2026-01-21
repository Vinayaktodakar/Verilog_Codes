`timescale 1ns / 1ps

module tb_traffic_light();
    reg clk;
    reg reset;
    wire [2:0] lights;

    // Instantiate FSM
    traffic_light_fsm uut (
        .clk(clk),
        .reset(reset),
        .lights(lights)
    );

    // 100MHz clock simulation
    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%4t | Reset=%b | Lights(RYG)=%b", $time, reset, lights);
        
        // Initial state
        clk = 0; reset = 1;
        #20 reset = 0; // Release reset

        // Observe at least two full cycles
        #500;
        $finish;
    end
endmodule
