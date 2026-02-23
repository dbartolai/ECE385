`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2026 11:32:36 AM
// Design Name: 
// Module Name: cla_4
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


module cla_4(       input  logic [3:0] a, b,
                    input  logic       cin,

                    output logic [3:0] s,
                    output logic       cout,
                    output logic       PG,
                    output logic       GG
        );
        
        logic [3:0] P, G;
        logic [4:0] C;

        assign P[0] = a[0] ^ b[0];
        assign P[1] = a[1] ^ b[1];
        assign P[2] = a[2] ^ b[2];
        assign P[3] = a[3] ^ b[3];

        assign G[0] = a[0] & b[0];
        assign G[1] = a[1] & b[1];
        assign G[2] = a[2] & b[2];
        assign G[3] = a[3] & b[3];
        
        assign C[0] = cin;
        assign C[1] = (P[0] & C[0]) | G[0];
        assign C[2] = (C[0] & P[0] & P[1]) | (G[0] & P[1]) | G[1];
        assign C[3] = (C[0] & P[0] & P[1] & P[2]) | (G[0] & P[1] & P[2]) | (G[1] & P[2]) | G[2];
        assign C[4] = (C[0] & P[0] & P[1] & P[2] & P[3]) | (G[0] & P[1] & P[2] & P[3]) | (G[1] & P[2] & P[3]) | (G[2] & P[3]) | G[3];
    
        assign s[0] = P[0]  ^ C[0];
        assign s[1] = P[1]  ^ C[1];
        assign s[2] = P[2]  ^ C[2];
        assign s[3] = P[3]  ^ C[3];

        assign cout = C[4];
        assign PG = P[0] & P[1] & P[2] & P[3];
        assign GG = G[3] | (G[2] & P[3]) | (G[1] & P[2] & P[3]) | (G[0] & P[1] & P[2] & P[3]);

    
endmodule
