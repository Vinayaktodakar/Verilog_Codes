module shift_reg_siso (
    input  clk,      // System clock
    input  reset,    // Synchronous reset (active high)
    input  si,       // Serial input
    output so        // Serial output
);

    reg [3:0] q; // Internal 4-bit storage

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;
        end else begin
            // Shift logic: Move bits left and insert 'si' at the LSB
            // q[3] is shifted out, q[2] moves to q[3], etc.
            q <= {q[2:0], si};
        end
    end

    // The serial output is the most significant bit of the register
    assign so = q[3];

endmodule
