`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2025 01:34:44 PM
// Design Name: 
// Module Name: part2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module pipelined_ripple_carry_adder (
    input clk,
    input [127:0] a, b,
    input cin,
    output reg [127:0] sum,
    output reg cout
);
    // Intermediate wires for sum and carry signals
    wire [127:0] sum_intermediate;
    wire [8:0] carry_intermediate;

    // Pipeline registers for input values (a, b, cin)
    reg [127:0] a_reg, b_reg;
    reg cin_reg;
    
    // Pipeline registers for intermediate sum and carry values
    reg [127:0] sum_stage[0:7];
    reg [8:0] carry_stage[0:7];
    
    // Instantiating 8 16-bit ripple carry adders for the 128-bit adder
    wire [127:0] sum_wire;
    wire [8:0] carry_wire;
    
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : adder_stage
            ripple_carry_adder #(16) adder (
                .a(a_reg[(i+1)*16-1:i*16]), 
                .b(b_reg[(i+1)*16-1:i*16]), 
                .cin(i == 0 ? cin_reg : carry_stage[i-1][i]), 
                .sum(sum_wire[(i+1)*16-1:i*16]), 
                .cout(carry_wire[i])
            );
        end
    endgenerate
    
    initial begin
        a_reg <= 128'b0;
        b_reg <= 128'b0;
        cin_reg <= 0;
        
        //sum_stage[0] <= 128'b0;
        //carry_stage[0] <= 9'b0;
       
        // Clear pipeline registers
        for (integer i = 0; i < 8; i = i + 1) begin
            sum_stage[i] <= 128'b0;
            carry_stage[i] <= 9'b0;
        end
    end
    
    // Sequential logic for pipelining and output
    always @(posedge clk) begin
        // Output the result from the 8th stage (final pipeline stage)
        sum <= sum_stage[7];
        cout <= carry_stage[7];  // Carry-out is from the final carry register
        
        // Register inputs
        a_reg <= a;
        b_reg <= b;
        cin_reg <= cin;

        // Shift the pipeline registers
        for (integer i = 0; i < 7; i = i + 1) begin
            sum_stage[i+1] <= sum_stage[i];
            carry_stage[i+1] <= carry_stage[i];
        end

        // Load the new stage values from the current adder
        sum_stage[0] <= sum_wire;
        carry_stage[0] <= carry_wire;
        
        $display("sum_wire: %d", sum_wire);
        $display("sum_stage[0]: %d", sum_stage[0]);
        $display("sum_stage[1]: %d", sum_stage[1]);
        $display("sum_stage[2]: %d", sum_stage[2]);
        $display("sum_stage[3]: %d", sum_stage[3]);
        $display("sum_stage[4]: %d", sum_stage[4]);
        $display("sum_stage[5]: %d", sum_stage[5]);
        $display("sum_stage[6]: %d", sum_stage[6]);
        $display("sum_stage[7]: %d", sum_stage[7]);
    end
endmodule







