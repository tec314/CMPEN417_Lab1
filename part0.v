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
    output s, cout
    );
    
    //Declare the wires
    wire sum1, carry1, carry2;
    
    //Calculate the sum using xor
    xor(sum1, a, b);
    xor(s, sum1, cin);
    
    //Calculate the carry using and and or gates
    and(carry1, a, b);
    and(carry2, sum1, cin);
    or(cout, carry1, carry2);
    
endmodule
