`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2026 01:36:25 PM
// Design Name: 
// Module Name: multiplier
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


module shift (
        input logic [16:0] S_in,
        output logic [16:0] S_out
    );

    assign S_out = {S_in[16], S_in[16:1]};

endmodule

module reset (
        input logic [7:0] S,
        output logic [7:0] A, B,
        output logic X);

    assign A = 8'h00;
    assign B = S;
    assign X = 1'b0;

endmodule




module multiplier(
        input logic[7:0] S,
        input logic run, clk, reset,
        output logic[3:0] hex_grid,
        output logic[7:0] hex_seg, Aval, Bval,
        output logic Xval
    );

    // internal declarations
    logic[7:0] A_reset, B_reset, S_S;
    logic X_reset, run_SH, reset_SH;


    reset RESET (.A(A_reset), .B(B_reset), .S(S_S), .X(X_reset));

    logic[7:0] A_add;
    logic X_add;

    logic[7:0] A_sub;
    logic X_sub;


    adder9 ADD (.A({Aval[7], Aval}), .B({S[7], S}), .sub_select(1'b0), .S({X_add, A_add})); // NOTE: we don't need cout

    adder9 SUB (.A({Aval[7], Aval}), .B({S[7], S}), .sub_select(1'b1), .S({X_sub, A_sub})); // A-S

    logic[7:0] A_shift, B_shift;
    logic X_shift;

    shift SHIFT (.S_in({Xval, Aval, Bval}), .S_out({X_shift, A_shift, B_shift})); // use for shift state

    //control logic
    logic add, sub, shift, clr_ld, start_multiply;

    control CTRL (
        .clk(clk),
        .reset(reset_SH),
        .run(run_SH),
        .M(Bval[0]),
        .add_out(add),
        .sub_out(sub),
        .shift_out(shift),
        .clr_ld(clr_ld),
        .start_multiply(start_multiply)
    );



    logic[7:0] A_new, B_new;
    logic X_new;


    always_comb begin 
        //defualt to remove infered latches
        A_new = Aval;
        B_new = Bval;
        X_new = Xval;

        if (clr_ld) begin
            A_new = A_reset;
            B_new = B_reset;
            X_new = X_reset;
        end
        
        else if (start_multiply) begin
            A_new = 8'h00;
            X_new = 1'b0;
        end
    


        else if (add) begin
            A_new = A_add;
            X_new = X_add;
        end

        else if (sub) begin
            A_new = A_sub;
            X_new = X_sub;
        end

        else if (shift) begin
            A_new = A_shift;
            B_new = B_shift;
            X_new = X_shift;
        end

    end

    //UPDATE REGISTERS
    always_ff @(posedge clk) begin
        Aval <= A_new;
        Bval <= B_new;
        Xval <= X_new;
    end

    HexDriver h0 (.clk(clk), .reset(reset), .in({Bval[7:4], Bval[3:0], Aval[7:4], Aval[3:0]}), .hex_seg(hex_seg), .hex_grid(hex_grid));
    sync_debounce Sin_sync [7:0](.Clk(clk), .d(S), .q(S_S));
    sync_debounce button_sync [1:0](.Clk(clk), .d({run, reset}), .q({run_SH, reset_SH}));

endmodule
