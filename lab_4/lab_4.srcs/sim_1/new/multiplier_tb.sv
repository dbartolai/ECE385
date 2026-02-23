`timescale 1ns / 1ps

module testbench8();

    timeunit 10ns;
    timeprecision 1ns;

    // DUT Signals
    logic clk;
    logic reset;
    logic run;
    logic [7:0] S;

    logic [7:0] hex_seg;
    logic [3:0] hex_grid;
    logic [7:0] Aval;
    logic [7:0] Bval;
    logic Xval;

    // Verification variables
    logic signed [7:0]  multiplicand;
    logic signed [7:0]  multiplier;
    logic signed [16:0] expected;
    logic signed [16:0] result;

    // DUT
    multiplier mult (
        .S(S),
        .run(run),
        .clk(clk),
        .reset(reset),
        .hex_grid(hex_grid),
        .hex_seg(hex_seg),
        .Aval(Aval),
        .Bval(Bval),
        .Xval(Xval)
    );

    // Clock
    initial clk = 0;
    always #1 clk = ~clk;

    initial begin

        //------------------------------------------------
        // INITIALIZE
        //------------------------------------------------
        reset = 0;
        run   = 0;
        S     = 0;

        //------------------------------------------------
        // PRESS RESET (simulate real button press)
        //------------------------------------------------
        reset = 1;
        repeat (80) @(posedge clk);   // HOLD LONG
        reset = 0;

        repeat (40) @(posedge clk);   // allow FSM to settle

        //------------------------------------------------
        // TEST: 7 * 59
        //------------------------------------------------
        multiplicand = 7;
        multiplier   = 59;
        expected     = multiplicand * multiplier;

       
        S = multiplier;
        repeat (10) @(posedge clk);   // allow S to sync

        //------------------------------------------------
        // PRESS RUN (simulate human press)
        //------------------------------------------------
        run = 1;
        repeat (80) @(posedge clk);   // HOLD LONG ENOUGH FOR DEBOUNCE
        run = 0;

        //------------------------------------------------
        // WAIT FOR MULTIPLICATION TO COMPLETE
        //------------------------------------------------
        repeat (120) @(posedge clk);

        //------------------------------------------------
        // CHECK RESULT
        //------------------------------------------------
        result = $signed({Xval, Aval, Bval});

        assert (result == expected)
            else $error("FAIL (+/+): 7 * 59 expected %0d got %0d",
                        expected, result);

        //------------------------------------------------
        // END
        //------------------------------------------------
        repeat (40) @(posedge clk);
        $finish;

    end

endmodule