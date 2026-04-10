`timescale 1ns / 1ps

module tb_digital_lock_top;

reg clk, rst, in;
wire unlock;

// Instantiate digital_lock_top as DUT
digital_lock_top uut (
    .clk(clk),
    .rst(rst),
    .in(in),
    .unlock(unlock)
);

// Clock generation (10ns time period)
always #5 clk = ~clk;

// Task: send 1 bit per clock cycle 
task send_bit(input bit_val);
begin
    @(negedge clk);  // change input before rising edge
    in = bit_val;
end
endtask

initial begin
    // Initialize signals
    clk = 0;
    rst = 1;
    in  = 0;

    // Apply reset
    #12 rst = 0;

    //  TEST 1: Correct sequence (1011)
    send_bit(1);
    send_bit(0);
    send_bit(1);
    send_bit(1);

    // Wait to observe unlock
    repeat(4) @(posedge clk);

    //  TEST 2: Incorrect sequence (1101)
    send_bit(1);
    send_bit(1);
    send_bit(0);
    send_bit(1);

    repeat(4) @(posedge clk);

    //  TEST 3: Random sequence
    send_bit(0);
    send_bit(1);
    send_bit(1);
    send_bit(0);

    repeat(4) @(posedge clk);

    // TEST 4: Correct sequence again (1011)
    send_bit(1);
    send_bit(0);
    send_bit(1);
    send_bit(1);

    repeat(6) @(posedge clk);

    $finish;
end

endmodule