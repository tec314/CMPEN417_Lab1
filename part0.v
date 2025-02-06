`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2025 11:29:09 AM
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
output sum, out
);
wire abxor;
wire aband;
wire cinand;
xor xor1(abxor, a, b);
xor xor2(sum, abxor, cin);
and and1(aband, a,b);
and and2(cinand, abxor, cin);
or or1(out, cinand, aband);
endmodule