module seq_111(clk,rst,in,out);
  input clk,rst,in;
  output reg out;

  parameter [1:0] s0=0,
  		  s1=1,
		  s2=2;
  
  reg [1:0] c_state,nx_state;

  always @(posedge clk or negedge rst) begin
	  if(rst) c_state <= s0;
	  else     c_state <= nx_state;
  end
 

always @(*) begin
     nx_state = s0; // Default state to avoid latches
     out = 0;       // Default output
     
     case (c_state) 
         s0: nx_state = in ? s1 : s0;
         s1: nx_state = in ? s2 : s0;
         s2: begin
             if (in) begin
                 nx_state = s2; 
                 out = 1;
             end else begin
                 nx_state = s0;
                 out = 0;
             end
         end
         default: nx_state = s0;
     endcase
 end
 endmodule














module tb;
  reg in, clk, rst;
  wire out;
  /*integer i; 
  reg [15:0] data = 16'b0110_1110_1111_0010;*/


  seq_111 uut(.clk(clk), .rst(rst), .in(in), .out(out));

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    rst = 1; 
    in = 0;
    
    
    #10 rst = 0; 
    #5  in=0;
    #10 in=1;
    #10 in=1;
#10 in=1;
#10 in=1;
#10 in=1;
#10 in=0;
#10 in=1;
#10 in=1;
#10 in=0;

    $finish;
  end

  initial begin 
    $monitor("Time: %0t | IN: %b | RST: %b | OUT: %b", $time, in, rst, out);
  end
endmodule
