//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2026 02:22:57 PM
// Design Name: 
// Module Name: testbench
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


module testbench();
    timeunit 10 ns;
    timeprecision 1ns;
    
    
logic        Clk;     // Internal
logic        Reset;   // Push button nand
logic        LoadA;   // Push button 1
logic        LoadB;   // Push button 2
logic        Execute; // Push button 3
logic [3:0]  Din;       
logic [2:0]  F;     // Function select 
logic [1:0]  R;       // Routing select

logic [3:0]  LED;    // DEBUG
logic [3:0]  Aval;    // DEBUG
logic [3:0]  Bval;    // DEBUG
logic [7:0]  hex_seg; // Hex display control
logic [3:0]  hex_grid; // Hex display control

Processor test_processor(.*); // .* connects all signals with the same name



initial begin: Clock_Initialization
    Clk = 0;
    forever #1 Clk = ~Clk;
end

initial begin: Test_Body
    #5
    Reset = 1;
    #2 Reset = 0;
    
    #1 Din = 4'b0100;
    LoadA = 1;
    #2 LoadA = 0;
    
    
    #2 Din = 4'b1111;
    LoadB = 1;
    #2 LoadB = 0; 
    
    F = 3'b010; //XOR
    R = 2'b01; //result to b
    
    #1 Execute = 1;
    
end

endmodule
