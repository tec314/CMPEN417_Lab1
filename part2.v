`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2025 11:34:28 AM
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

//.a(inputA), .b(inputB), .cin(1'b0), .s(tmp_result), .cout(cout),.clk(clk));  
/*
module part2(
    input clk,
    input [127:0] a, b,
    input cin,
    output reg [127:0] s,
    output reg cout
);

    //Declare registers for the pipeline
    reg [7:0] a_reg [0:127];
    reg [7:0] b_reg [0:127];
    reg cin_reg [0:7];
    reg [7:0] s_reg [0:127];
    reg cout_reg [0:7];
    
    //Carry wires
    wire [7:0] carry;
    wire [127:0] sum;
    
    //Instantiate the 8 16-bit ripple carry adders
    genvar i;
    generate
        for(i=0; i<8; i=i+1) begin: adders
            part1 #(16) adder(.a(a_reg[i][(i+1)*16-1:i*16]), .b(b_reg[i][(i+1)*16-1:i*16]), .cin((i == 0) ? cin_reg[i] : carry[i-1]), 
            .s(sum[(i+1)*16-1:i*16]), .cout(carry[i]));
        end
    endgenerate




    // Sequential logic
    //Declare integer for for loop
    integer j;
    
    //Initialization block
    initial begin
        //Initialize the data
        a_reg[0] <= 0;
        b_reg[0] <= 0;
        cin_reg[0] <= 0;
        
        for(integer i=0; i<8; i=i+1)begin
            cout_reg[i]=0;
            s_reg[i]=0;
        end
    end
    
    
    //Start always block
    always @(posedge clk) begin    
        //REgister inputs
        a_reg[0] <= a;
        b_reg[0] <= b;
        cin_reg[0] <= cin;
               
        //Iterate through the pipeline stages
        for(j=1; j<8; j=j+1) begin
            a_reg[j] <= a_reg[j-1];
            b_reg[j] <= b_reg[j-1];
            cin_reg[j] <= cin_reg[j-1];
            s_reg[j] <= s_reg[j-1];
            cout_reg[j] <= cout_reg[j-1];
        end
    
        //store the computations
        s_reg[7] <= sum;
        cout_reg[7] <= carry[7];
        
        //Assign the output
        s <= s_reg[7];
        cout <= cout_reg[7];
    
        s <= s_reg[7];
        cout <= cout_reg[7];
    end 

endmodule*/


//Toms stuff----------------------------------------------------

module part2 (
    input clk,
    input [127:0] a, b,
    input cin,
    output reg [127:0] s,
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
    reg [7:0] carry_stage = 0;
    
    // Instantiating 8 16-bit ripple carry adders for the 128-bit adder
    wire [127:0] sum_wire;
    wire [8:0] carry_wire;
    
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : adder_stage
            part1 #(16) adder (
                .a(a_reg[(i+1)*16-1:i*16]), 
                .b(b_reg[(i+1)*16-1:i*16]), 
                .cin(i==0 ? 0 : carry_stage[i]), 
                .s(sum_wire[(i+1)*16-1:i*16]), 
                .cout(carry_wire[i])
            );
        end
    endgenerate
    /*
    initial begin
        a_reg = 128'b0;
        b_reg = 128'b0;
        cin_reg = 0;
        
        //sum_stage[0] <= 128'b0;
        //carry_stage[0] <= 9'b0;
       
        // Clear pipeline registers
        for (integer i = 0; i < 8; i = i + 1) begin
            //sum_stage[i] = 128'bX;//128'b0;
            carry_stage[i] = 1'bX;//9'b0;
        end
    end
    */
    // Sequential logic for pipelining and output
    always @(posedge clk) begin
        // Output the result from the 8th stage (final pipeline stage)
        s <= sum_stage[7];
        cout <= carry_stage[7];  // Carry-out is from the final carry register
        
        // Register inputs
        a_reg <= a;
        b_reg <= b;
        cin_reg <= cin;
        carry_stage <= {carry_stage[7:0], cin};
        // Shift the pipeline registers
        for (integer i = 0; i < 7; i = i + 1) begin
            sum_stage[i+1] <= sum_stage[i];
            
        end

        // Load the new stage values from the current adder
        sum_stage[0] <= sum_wire;
        
        
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
