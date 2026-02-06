// while using with en first comment remove and add comment , same for monitor also 

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
