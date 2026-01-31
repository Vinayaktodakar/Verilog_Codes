module mux_2_1(
    input   sel, a, b, 
    output  out // Using 'logic' is standard in SystemVerilog
);

    always_comb begin
        if(sel) out = b;
        else    out = a;
    end
    
endmodule
