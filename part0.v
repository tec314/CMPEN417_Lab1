`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2025 11:07:17 PM
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


module full_adder (
    input a, b, cin,
    output sum, cout
);
    wire w1, w2, w3;
    
    // Sum calculation using XOR gates
    xor (w1, a, b);
    xor (sum, w1, cin);
    
    // Carry-out calculation using AND and OR gates
    and (w2, a, b);
    and (w3, w1, cin);
    or (cout, w2, w3);
    
endmodule
