module seq_1101 (
    input clk,
    input rst,
    input in,
    output reg out
);

    parameter [1:0]
        s0 = 2'd0,
        s1 = 2'd1,
        s2 = 2'd2,
        s3 = 2'd3;

    reg [1:0] c_state, nx_state;

    // ---------------- State Register ----------------
    always @(posedge clk or negedge rst) begin
        if (!rst)
            c_state <= s0;
        else
            c_state <= nx_state;
    end

    // ---------------- Next State + Output ----------------
    always @(*) begin
        nx_state = s0;   // SAFE DEFAULT
        out = 1'b0;

        case (c_state)
            s0: nx_state = in ? s1 : s0;
            s1: nx_state = in ? s2 : s0;
            s2: nx_state = in ? s2 : s3;
            s3: begin
                nx_state = in ? s1 : s0;
                out = in;   // detect 1101
            end
            default: begin
                nx_state = s0;   // RECOVERY PATH
                out = 1'b0;
            end
        endcase
    end

endmodule


module tb;

    reg clk;
    reg rst;
    reg in;
    wire out;

    seq_1101 uut (
        .clk(clk),
        .rst(rst),
        .in(in),
        .out(out)
    );

    // Clock
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 0;
        in  = 0;

        // Apply reset
        #10 rst = 1;

        // Normal operation
        @(posedge clk) in = 1;   // s0 -> s1
        @(posedge clk) in = 1;   // s1 -> s2

        // ---------------- FORCE ILLEGAL STATE ----------------
        #1;
        force uut.c_state = 2'b11;   // illegal / corrupted state
        $display(">>> FSM CORRUPTED at time %0t", $time);

        // Hold for 1 cycle
        @(posedge clk);
        release uut.c_state;

        // FSM should recover to s0 automatically
        @(posedge clk);

        // Resume normal operation
        @(posedge clk) in = 1;
        @(posedge clk) in = 1;
        @(posedge clk) in = 0;
        @(posedge clk) in = 1;   // detect 1101

        #20 $finish;
    end

    // Monitor FSM recovery
    initial begin
        $monitor(
            "T=%0t | rst=%b | in=%b | state=%0d | next=%0d | out=%b",
            $time, rst, in, uut.c_state, uut.nx_state, out
        );
    end

endmodule

