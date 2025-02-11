`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2025 11:32:47 AM
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


module part2(
input [127:0] a,b,
input cin, clk,
output [127:0] s,
output cout
    );
    // 1-bit Carry register to hold carry values between 16-bit adder stages
    reg [8:0]carry_reg;
    // Input register to hold input values a,b
    reg [127:0] a_reg [0:7];
    reg [127:0] b_reg [0:7];
    // Output register to hold the sums
    reg [127:0] output_reg [0:7];
    
    //Wires for the generate function
    wire [127:0] output_wire; //Output wire
    wire [7:0] carry_wire; //Carry wire
    integer j;
    integer k;
    
    genvar i;
    generate
        for (i=0; i<8; i=i+1) begin : adder_combiner
            part1 #(.SIZE(16)) ac (
                .a(a_reg[i][(i+1)*16-1:i*16]),
                .b(b_reg[i][(i+1)*16-1:i*16]),
                .cin(carry_reg[i]), //Set to cin for first adder
                .s(output_wire[(i+1)*16-1:i*16]),
                .cout(carry_wire[i])
            );
        end
    endgenerate
    
    always @(posedge clk) begin
    
        // Assigning the input values to the first reg
        a_reg[0] <= a;
        b_reg[0] <= b;
        carry_reg[0] <= cin;
        
        for (j = 0; j < 9; j = j + 1) begin
            carry_reg[j+1] <= carry_wire[j];
        end
        
        for (j = 0; j < 8; j = j + 1) begin
            a_reg[j+1] <= a_reg[j];
            b_reg[j+1] <= b_reg[j];
        end         
        
        for (j = 0; j < 8; j = j + 1) begin
            output_reg[j+1] <= output_reg[j];
        end 
        
        k = 0;
        for (j = 0; j < 128; j = j + 1) begin
            
            output_reg[k][j] <= output_wire [j];
            if ((j%16 == 15)&(j != 0)) begin
                k = k + 1;
            end
  
        end  
        
    end
    
        
    // Makes the sum the last output
    assign s = output_reg[7];
    
    assign cout = carry_reg[8];
endmodule