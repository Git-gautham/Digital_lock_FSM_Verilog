`timescale 1ns / 1ps
module digital_lock_top (
    input clk,
    input rst,
    input in,
    output unlock
);

wire [3:0] seq;
wire shift_en, dp_rst;

datapath dp (
    .clk(clk),
    .rst(rst),
    .dp_rst(dp_rst),
    .in(in),
    .shift_en(shift_en),
    .seq(seq)
);

controller ctrl (
    .clk(clk),
    .rst(rst),
    .seq(seq),
    .shift_en(shift_en),
    .dp_rst(dp_rst),
    .unlock(unlock)
);

endmodule