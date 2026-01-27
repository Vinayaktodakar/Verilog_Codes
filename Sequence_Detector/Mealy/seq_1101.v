module seq_det (
    input  clk,
    input  rst,
    input  in,
    output reg out
);

    parameter [1:0]
        s0 = 2'b00,
        s1 = 2'b01,
        s2 = 2'b10,
        s3 = 2'b11;

    reg [1:0] state, nxt_st;

    // Next-state and output logic (Mealy FSM)
    always @(*) begin
        nxt_st = state;   // default
        out    = 1'b0;    // default

        case (state)
            s0: begin
                nxt_st = in ? s1 : s0;
            end

            s1: begin
                nxt_st = in ? s2 : s0;
            end

            s2: begin
                nxt_st = in ? s2 : s3;
            end

            s3: begin
                nxt_st = in ? s1 : s0;
                if (in)
                    out = 1'b1;   // detection
            end

            default: begin
                nxt_st = s0;
                out    = 1'b0;
            end
        endcase
    end

    // State register with async reset
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= s0;
        else
            state <= nxt_st;
    end

endmodule
