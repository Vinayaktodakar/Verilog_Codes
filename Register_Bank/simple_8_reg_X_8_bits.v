module register_bank_8x8 (
    input            clk,        // System Clock
    input            reset,      // Synchronous Reset
    input            we,         // Write Enable (Active High)
    input      [2:0] read_addr,  // 3-bit Read Address (0 to 7)
    input      [2:0] write_addr, // 3-bit Write Address (0 to 7)
    input      [7:0] data_in,    // 8-bit Data Input
    output reg [7:0] data_out    // 8-bit Data Output (Read Port)
);

    // Declare the memory array: 8 entries, each 8 bits wide
    reg [7:0] mem [0:7];

    // Block 1: Write Logic (Synchronous)
    always @(posedge clk) begin
        if (reset) begin
            // Optional: clear all registers on reset (can be time-consuming to simulate fully)
            // for (int i = 0; i < 8; i++) begin
            //     mem[i] <= 8'b0;
            // end
        end else if (we) begin
            // Write data_in to the selected register address on the clock edge
            mem[write_addr] <= data_in;
        end
    end

    // Block 2: Read Logic (Asynchronous read port)
    // The output updates whenever the read_addr changes
    always @(*) begin
        data_out = mem[read_addr];
    end

endmodule
