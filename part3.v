`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2025 11:32:47 AM
// Design Name: 
// Module Name: part3
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


module part3 #(parameter SIZE=16)(
    input [SIZE-1:0] a, b,
    input cin, clk,
    output reg [SIZE:0] s,
    output reg cout
    );
    always@(posedge clk) begin
        s <= a+b+cin;
        cout <= s[SIZE];
    end
    
endmodule
