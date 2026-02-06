//===================================================================================
//===================== Up/Down Counter with Watchdog Timer ==========================
//===================================================================================
module up_dwn_watchdog #(
    parameter CNT_WIDTH = 4,
    parameter MAX_COUNT = (1<<CNT_WIDTH)-1
)(
    input  wire                  clk,
    input  wire                  rst,
    input  wire                  up_dn,
    input  wire                  en,
    input  wire                  service,   // Watchdog service (kick)
    output reg  [CNT_WIDTH-1:0]  count,
    output reg                   timeout
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count   <= 0;
            timeout <= 1'b0;
        end 
        else if (service) begin
            count   <= 0;       // Reload watchdog
            timeout <= 1'b0;    // Clear timeout
        end 
        else if (en && !timeout) begin
            if (up_dn)
                count <= count + 1;
            else
                count <= count - 1;

            // Timeout condition
            if (count == MAX_COUNT)
                timeout <= 1'b1;
        end
    end

endmodule
//===================================================================================
//===================== Testbench for Watchdog Timer ================================
//===================================================================================
module tb;

  reg clk, rst, up_dn, en;
  reg service;
  wire [4:0] count;
  wire timeout;

  // DUT instantiation
  up_dwn_watchdog #(.CNT_WIDTH(5)) uut (
      .clk(clk),
      .rst(rst),
      .up_dn(up_dn),
      .en(en),
      .service(service),
      .count(count),
      .timeout(timeout)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
      // Initial values
      clk     = 0;
      rst     = 1;
      en      = 0;
      up_dn  = 1;   // count up
      service= 0;

      // Apply reset
      #15;
      rst = 0;
      en  = 1;

      // -------------------------------
      // Case 1: Proper watchdog service
      // -------------------------------
      #40;
      service = 1;     // kick watchdog
      #10;
      service = 0;

      #40;
      service = 1;     // kick again
      #10;
      service = 0;

      // -------------------------------
      // Case 2: Missed service → timeout
      // -------------------------------
      #200;            // no service → expect timeout

      // -------------------------------
      // Case 3: Recovery using reset
      // -------------------------------
      #20;
      rst = 1;
      #10;
      rst = 0;
      en  = 1;

      // -------------------------------
      // Case 4: Down-count watchdog
      // -------------------------------
      up_dn = 0;
      #30;
      service = 1;
      #10;
      service = 0;

      #0;            // let it timeout again

      #20;
      $finish;
  end

  // Monitor
  initial begin
      $monitor(
        "TIME=%0t | rst=%0d | en=%0d | up_dn=%0d | service=%0d | count=%0d | timeout=%0d",
        $time, rst, en, up_dn, service, count, timeout
      );
  end

  // Dump waveform
  initial begin
      $dumpfile("watchdog.vcd");
      $dumpvars(0, tb);
  end

endmodule

