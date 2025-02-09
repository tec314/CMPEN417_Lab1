`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2025 11:34:28 AM
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


module part1 #(parameter SIZE = 16) (
    input [SIZE-1:0] a, b,
    input cin,
    output [SIZE-1:0] s,
    output cout
);
    
    //Declare carry for SIZE+1 carries
    wire [SIZE:0] carry;
    
    //Initialize the first carry
    assign carry[0] = cin;
    
    
    //Start the generate 
    genvar i;
    
    generate
        for(i=0; i<SIZE; i=i+1) begin: size_bit_adder
            part0 adder(.a(a[i]), .b(b[i]), .cin(carry[i]), .s(s[i]), .cout(carry[i+1]));
        end
    endgenerate
    
    //Assign the final carry out
    assign cout=carry[SIZE];
    
endmodule
