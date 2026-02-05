//-----------------------------------------------------------------
//-----------------------Process-2---------------------------------
//-----------------------------------------------------------------


module seq_1101(clk,rst,in,out);
  input clk,rst,in;
  output reg out;

  parameter [1:0] s0=0,
  		  s1=1,
		  s2=2,
	  	  s3=3;
  
  reg [1:0] c_state,nx_state;

  always @(posedge clk or negedge rst) begin
	  if(rst) c_state = s0;
	  else     c_state = nx_state;
  end

  always @(*) begin
	  case(c_state)
		  s0 : begin  nx_state=in ? s1:s0; out=0; end
		  s1 : begin  nx_state=in ? s2:s0; out=0; end
		  s2 : begin  nx_state=in ? s2:s3; out=0; end
		  s3 : begin  nx_state=in ? s1:s0; out=in ? 1:0; end
		  default : nx_state=s0;
	  endcase
  end
endmodule

//-----------------------------------------------------------------
//-----------------------Process-3---------------------------------
//-----------------------------------------------------------------
/*
module seq_1101(clk,rst,in,out);
  input clk,rst,in;
  output reg out;

  parameter [1:0] s0=0,
  		  s1=1,
		  s2=2,
	  	  s3=3;
  
  reg [1:0] c_state,nx_state;

  always @(posedge clk) begin
	  if(rst) c_state <= s0;
	  else    c_state <= nx_state;
  end

  always @(*) begin
	  case(c_state)
		  s0 : nx_state=in ? s1:s0;
		  s1 : nx_state=in ? s2:s0; 
		  s2 : nx_state=in ? s3:s2;  
		  s3 : nx_state=in ? s2:s0; 
		  default : nx_state=s0;
	  endcase
  end
  always @(*) begin
    if (c_state == s3 && in == 1'b1)
        out <= 1'b1;
    else
        out <= 1'b0;
    end
endmodule
*/





//-----------------------------------------------------------------
//-----------------------One_Hot_encoding--------------------------
//-----------------------------------------------------------------
/*
module seq_1101(clk,rst,in,out);
  input clk,rst,in;
  output reg out;

  parameter [3:0] s0=4'b0001,
  		  s1=4'b0010,
		  s2=4'b0100,
	  	  s3=4'b1000;
  
  reg [3:0] c_state,nx_state;

  always @(posedge clk) begin
	  if(rst) c_state <= s0;
	  else    c_state <= nx_state;
  end

  always @(*) begin
	  case(c_state)
		  s0 : nx_state=in ? s1:s0;
		  s1 : nx_state=in ? s2:s0; 
		  s2 : nx_state=in ? s3:s2;  
		  s3 : nx_state=in ? s2:s0; 
		  default : nx_state=s0;
	  endcase
  end
  always @(*) begin
    if (c_state == s3 && in == 1'b1)
        out <= 1'b1;
    else
        out <= 1'b0;
    end
endmodule
*/



//-----------------------------------------------------------------
//-----------------------Timeout Mechanism-------------------------
//-----------------------------------------------------------------

/*
module seq_1101(clk,rst,in,out);
  input clk,rst,in;
  output reg out;

  parameter [3:0] s0=4'b0001,
  		  s1=4'b0010,
		  s2=4'b0100,
	  	  s3=4'b1000;
  parameter N=5;
  reg [3:0] c_state,nx_state,timer;

  always @(posedge clk) begin
	  if(rst) c_state <= s0;
	  else    c_state <= nx_state;
  end

  always @(*) begin
	if (timer >= N-1) begin
            nx_state = s0;
        end 
	else begin
	  case(c_state)
		  s0 : nx_state=in ? s1:s0;
		  s1 : nx_state=in ? s2:s0; 
		  s2 : nx_state=in ? s2:s3;  
		  s3 : nx_state=in ? s1:s0; 
		  default : nx_state=s0;
	  endcase
	end
  end
  always @(*) begin
    if (c_state == s3 && in == 1'b1)
        out <= 1'b1;
    else
        out <= 1'b0;
  end

  always @(posedge clk) begin
        if (rst) begin
            c_state <= s0;
            timer   <= 0;
        end 
	else begin
            c_state <= nx_state;
            if (nx_state == c_state && c_state != s0) 
                timer <= timer + 1;
            else
                timer <= 0;
        end
  end
  initial begin
	$monitor("Timer : %0d, | input : %0d | current_state : %0d | next_state : %0d | out : %0d |",timer,in,c_state,nx_state,out);
	#200
	$finish;
  end 
endmodule
*/	

//-----------------------------------------------------------------
//----------------------- Stall or Hold ---------------------------
//-----------------------------------------------------------------

/*
module seq_1101 (
    input  clk,
    input  rst,      // active-high reset
    input  stall,    // back-pressure / hold
    input  in,
    output reg out
);

    // State encoding
    parameter [1:0]
        s0 = 2'd0,
        s1 = 2'd1,
        s2 = 2'd2,
        s3 = 2'd3;

    reg [1:0] c_state, nx_state;

    // -------------------------------------------------
    // Sequential logic (STATE HOLD ON STALL)
    // -------------------------------------------------
    always @(posedge clk) begin
        if (rst)
            c_state <= s0;
        else if (stall)
            c_state <= c_state;   // HOLD state (back-pressure)
        else
            c_state <= nx_state;
    end

    // -------------------------------------------------
    // Next-state + output logic
    // -------------------------------------------------
    always @(*) begin
        // Defaults
        nx_state = c_state;
        out      = 1'b0;

        case (c_state)
            s0: begin
                nx_state = in ? s1 : s0;
            end

            s1: begin
                nx_state = in ? s2 : s0;
            end

            s2: begin
                nx_state = in ? s3 : s2;
            end

            s3: begin
                nx_state = in ? s2 : s0;
                out      = in ? 1'b1 : 1'b0;  // detect 1101
            end

            default: begin
                nx_state = s0;
            end
        endcase
    end

endmodule
*/















//-------------------------------------------------------------------
//-------------------------Test Bench--------------------------------
//-------------------------------------------------------------------

module tb;
 reg clk,rst,in;
 wire out;

 seq_1101 uut(.clk(clk), .rst(rst), .in(in), .out(out));

 always #5 clk=~clk;

 initial begin
	 $monitor("Time: %0t | rst: %b | in: %b | out: %b", $time, rst, in, out);
	 clk=0;
	 rst=1;
	 #15
	 rst=0;

	 #00 in=1;
	 #10 in=0;	
	#10 in=1;
	#10 in=1;
	#10 in=0;
	#10 in=1;
	#10 in=1;
	#10 in=0;
	#10 in=1;
	//#100 
	#10 in=0;
	#10 in=0;
	#10 in=0;

	#20 
	$finish;
end

endmodule





//-------------------------------------------------------------------
//-------------------------Test Bench with stall --------------------
//-------------------------------------------------------------------
/*module tb;

    reg clk;
    reg rst;
    reg in;
    reg stall;
    wire out;

    // DUT instantiation
    seq_1101 uut (
        .clk   (clk),
        .rst   (rst),
        .stall (stall),
        .in    (in),
        .out   (out)
    );

    // Clock generation: 10 time units
    always #5 clk = ~clk;

    initial begin
        // ---------------- Initialization ----------------
        clk   = 0;
        rst   = 1;
        in    = 0;
        stall = 0;

        // Hold reset for 2 clock cycles
        repeat (2) @(posedge clk);
        rst = 0;

        // ---------------- Apply sequence 1101 ----------------
        @(posedge clk) in = 1;   // s0 -> s1
        @(posedge clk) in = 1;   // s1 -> s2

        // ---------------- APPLY STALL ----------------
        @(posedge clk) begin
            stall = 1;           // back-pressure ON
            in    = 0;           // input changes ignored
        end

        // FSM should HOLD state here
        repeat (3) @(posedge clk);

        // ---------------- RELEASE STALL ----------------
        @(posedge clk) stall = 0;

        // Resume sequence
        @(posedge clk) in = 0;   // s2 -> s3
        @(posedge clk) in = 1;   // DETECT 1101 (out = 1)

        // ---------------- Extra cycles ----------------
        @(posedge clk) in = 0;
        repeat (3) @(posedge clk);

        $finish;
    end

    // ---------------- Monitor ----------------
    initial begin
        $monitor(
            "T=%0t | rst=%b | stall=%b | in=%b | state=%0d | out=%b",
            $time, rst, stall, in, uut.c_state, out
        );
    end

endmodule
*/
