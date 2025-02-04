`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2025 11:34:28 AM
// Design Name: 
// Module Name: part0
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


module part0(
    input a, b, cin,
    output sum, cout
    );
    
    wire sum1, sum2, carry1, carry2;
    xor(sum1, a, b);
    xor(sum, sum1, cin);
    and(carry1, a, b);
    and(carry2, sum1, cin);
    or(cout, carry1, carry2);
    
endmodule
