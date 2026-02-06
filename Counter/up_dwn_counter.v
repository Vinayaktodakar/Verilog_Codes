//===================================================================================
//=====================Normal Up Down Counter =======================================
//===================================================================================

module up_dwn #(parameter cnt_width=4) (clk,rst,up_dn,count);
  input clk,rst,up_dn;
  output reg [cnt_width-1:0] count;

  always @(posedge clk or posedge rst) begin
      if (rst) begin
          count <= 0;
      end 
      else   begin
          if (up_dn == 0) 
              count <= count - 1;
          else            
              count <= count + 1;
      end
  end

endmodule

//===================================================================================
//===================== Up Down Counter with enable==================================
//===================================================================================
/*
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


*/

//===================================================================================
//===================== Testbench Same for Both =====================================
//===================================================================================
module tb;
  reg clk,rst,up_dn,en;
  wire [4:0] count;
  
 up_dwn #(.cnt_width(5)) uut( .clk(clk), .rst(rst), .up_dn(up_dn), .count(count));
 //up_dwn #(.cnt_width(5)) uut( .clk(clk), .rst(rst), .up_dn(up_dn), .count(count), .en(en));
  always #5 clk= ~clk;
  initial begin
	  clk=0;
	  rst=1;
	  up_dn=0;
	  #15
	  en=0;
	  rst=0;
	  #5 en=1;
	  up_dn=1;
	  #170
	  en=0;
	  up_dn=0;
	  #60 en=1;
	  rst=1;
	  #10
	  rst=0;
	  up_dn=1;
	  #100
	   up_dn=0;
	  #100
	  $finish;
  end
  initial $monitor($time,"   up or down : %0d, | rst :%0d | count : %0d | ",up_dn,rst,count);
  //initial $monitor($time,"   up or down : %0d, | rst :%0d | en : %0d | count : %0d | ",up_dn,rst,en,count);
endmodule

