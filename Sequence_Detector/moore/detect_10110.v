// Code your design here
module seq_det_10110 (
    input  clk,
    input  rst,
    input  in,
    output out
);

    parameter [2:0]
        s0 = 3'b000,
        s1 = 3'b001,
        s2 = 3'b010,
        s3 = 3'b011,
        s4 = 3'b100,
        s5 = 3'b101;

    reg [2:0] state, nxt_st;

    // Next-state logic
    always @(*) begin
        case (state)
            s0: nxt_st = in ? s1 : s0;
            s1: nxt_st = in ? s1 : s2;
            s2: nxt_st = in ? s3 : s0;
            s3: nxt_st = in ? s4 : s2;
            s4: nxt_st = in ? s1 : s5;
            s5: nxt_st = in ? s3 : s0;
            default: nxt_st = s0;
        endcase
    end

    // State register with async reset
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= s0;
        else
            state <= nxt_st;
    end

    // Moore output
    assign out = (state == s5);

endmodule
