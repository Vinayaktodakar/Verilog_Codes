//===================================================================================
//===================== Up Down Counter with enable==================================
//===================================================================================
module up_dwn #(parameter cnt_width=4) (clk,rst,up_dn,en,count);
  input clk,rst,up_dn,en;
  output reg [cnt_width-1:0] count;
  always @(posedge clk ) begin
      if (rst) begin
          count <= 0;
      end 
      else if (en == 1) begin
          if (up_dn == 0) 
              count <= count - 1;
          else            
              count <= count + 1;
      end
  end

endmodule
