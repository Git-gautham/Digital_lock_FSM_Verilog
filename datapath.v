`timescale 1ns / 1ps
module datapath (
    input clk,
    input rst,
    input dp_rst,
    input in,
    input shift_en,
    output reg [3:0] seq
);

always @(posedge clk or posedge rst) begin
    if (rst || dp_rst)
        seq <= 4'b0000;
    else if (shift_en)
        seq <= {seq[2:0], in};
end

endmodule