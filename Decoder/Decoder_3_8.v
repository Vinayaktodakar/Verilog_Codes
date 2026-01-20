module decoder_3to8 (
    input  [2:0] in,    // 3-bit selection input
    input        enable, // Active high enable
    output [7:0] out    // 8-bit decoded output
);

    // Using a continuous assignment with a left-shift operator
    // If enable is 1, shift '1' to the position indicated by 'in'
    // If enable is 0, all outputs are 0
    assign out = (enable) ? (8'b00000001 << in) : 8'b00000000;

endmodule
