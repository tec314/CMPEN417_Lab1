`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2025 11:32:47 AM
// Design Name: 
// Module Name: part5
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


module ahead_adder(
    input [3:0] a, b,
    input cin,
    output [3:0] s,
    output cout
    );
    wire [3:0] g, p;    
    wire [3:0] carry;        

    assign g = a & b;        
    assign p = a | b;       

    assign carry[0] = cin;
    assign carry[1] = g[0] | (p[0] & carry[0]);
    assign carry[2] = g[1] | (p[1] & carry[1]);
    assign carry[3] = g[2] | (p[2] & carry[2]);
    assign cout = g[3] | (p[3] & carry[3]);
    assign s = a ^ b ^ carry[3:0];
endmodule

module ahead_adder_16b(
    input [15:0] a, b,
    input cin,
    output [15:0] s,
    output cout
);
wire carry[3:0];

assign carry[0]=cin;
genvar i;
    generate
        for (i=0; i<4; i=i+1) begin : adder_combiner
            ahead_adder aa (
                .a(a[(i+1)*4-1:i*4]),
                .b(b[(i+1)*4-1:i*4]),
                .cin(carry[i]), //Set to cin for first adder
                .s(s[(i+1)*16-1:i*16]),
                .cout(carry[i+1])
            );
        end
    endgenerate
assign cout = carry[3];

endmodule

module part5(
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
            ahead_adder_16b aa16 (
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
