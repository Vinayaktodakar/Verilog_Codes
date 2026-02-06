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
