`timescale 1ns / 1ps
module controller (
    input clk,
    input rst,
    input [3:0] seq,
    output reg shift_en,
    output reg dp_rst,
    output reg unlock
);

reg [1:0] state, next_state;
reg [2:0] count;

// States
parameter SHIFT = 2'b00,
          WAIT  = 2'b01,
          CHECK = 2'b10;

// State register (ONLY place where state updates)
always @(posedge clk or posedge rst) begin
    if (rst)
        state <= SHIFT;
    else
        state <= next_state;
end

// Counter (only during SHIFT)
always @(posedge clk or posedge rst) begin
    if (rst)
        count <= 0;

    else if (dp_rst)   
        count <= 0;

    else if (state == SHIFT) begin
        if (count == 3)
            count <= 0;
        else
            count <= count + 1;
    end
end

// Next-state logic
always @(*) begin
    case (state)
        SHIFT: next_state = (count == 3) ? WAIT : SHIFT;
        WAIT : next_state = CHECK;
        CHECK: next_state = SHIFT;
        default: next_state = SHIFT;
    endcase
end

// Output logic 
always @(posedge clk or posedge rst) begin
    if (rst) begin
        shift_en <= 1;
        dp_rst   <= 0;
        unlock   <= 0;
    end else begin
        // defaults
        shift_en <= 1;
        dp_rst   <= 0;
        unlock   <= 0;

        case (state)

            SHIFT: begin
                shift_en <= 1;
            end

            WAIT: begin
                shift_en <= 0; // stop shifting
            end

            CHECK: begin
                if (seq == 4'b1011)
                    unlock <= 1;

                dp_rst <= 1;   // reset after check
            end

        endcase
    end
end

endmodule