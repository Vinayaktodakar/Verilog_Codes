module seq_1101 (
    input  clk,
    input  rst,
    input  in,
    output reg out
);

    parameter [1:0]
        s0 = 2'd0,
        s1 = 2'd1,
        s2 = 2'd2,
        s3 = 2'd3;

    reg [1:0] c_state, nx_state;

    // -------------------------------------------------
    // State register
    // -------------------------------------------------
    always @(posedge clk or negedge rst) begin
        if (!rst)
            c_state <= s0;
        else
            c_state <= nx_state;
    end

    // -------------------------------------------------
    // Next-state + output logic
    // -------------------------------------------------
    always @(*) begin
        nx_state = c_state;
        out = 1'b0;

        case (c_state)
            s0: nx_state = in ? s1 : s0;
            s1: nx_state = in ? s2 : s0;
            s2: nx_state = in ? s2 : s3;
            s3: begin
                nx_state = in ? s1 : s0;
                out = in;
            end
        endcase
    end

    // -------------------------------------------------
    // ASSERTION: Legal state transitions only
    // -------------------------------------------------
    always @(posedge clk) begin
        if (rst) begin
            assert (
                (c_state == s0 && (nx_state == s0 || nx_state == s1)) ||
                (c_state == s1 && (nx_state == s0 || nx_state == s2)) ||
                (c_state == s2 && (nx_state == s2 || nx_state == s3)) ||
                (c_state == s3 && (nx_state == s0 || nx_state == s1))
            )
            else $error("Illegal FSM transition: %0d -> %0d", c_state, nx_state);
        end
    end

endmodule


//-------------------------------------------------------------------
//-------------------------Test Bench--------------------------------
//-------------------------------------------------------------------

module tb;
 reg clk,rst,in;
 wire out;

 seq_1101 uut(.clk(clk), .rst(rst), .in(in), .out(out));

 always #5 clk=~clk;

 initial begin
	 $monitor("Time: %0t | rst: %b | in: %b | out: %b", $time, rst, in, out);
	 clk=0;
	 rst=1;
	 #15
	 rst=0;

	 #00 in=1;
	 #10 in=0;
	#10 in=1;
	#10 in=1;
	#10 in=0;
	#10 in=1;
	#10 in=1;
	#10 in=0;
	#10 in=1;
	//#100
	#10 in=0;
	#10 in=0;
	#10 in=0;

	#20
	$finish;
end

endmodule
