module register_8bit (
    input            clk,      // System Clock
    input            sync_rst, // Synchronous Reset (Active High)
    input            load,     // Load Enable
    input      [7:0] data_in,  // 8-bit Data Input
    output reg [7:0] data_out  // 8-bit Data Output
);

    // Synchronous logic: triggers only on the rising edge of clk
    always @(posedge clk) begin
        if (sync_rst) begin
            // Reset the register to zero
            data_out <= 8'b00000000;
        end 
        else if (load) begin
            // Load new data if enable is high
            data_out <= data_in;
        end
        // If neither reset nor load is high, data_out remains unchanged
    end

endmodule
