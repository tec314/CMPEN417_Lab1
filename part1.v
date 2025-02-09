`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2025 11:29:09 AM
// Design Name: 
// Module Name: part1
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


module part1 #(parameter width=32)(
    input [width-1:0] a, b,
    input cin,
    output [width-1:0] s,
    output cout
    );
    
    wire [width:0] carry;
    assign carry[0] = cin;
    
    genvar i;
    generate
        for (i=0; i<width; i=i+1) begin : adder_resizer
            part0 ra (.a(a[i]), .b(b[i]), .cin(carry[i]), .sum(s[i]), .cout(carry[i+1]));
        end
    endgenerate
    assign cout = carry[width];
    
endmodule
