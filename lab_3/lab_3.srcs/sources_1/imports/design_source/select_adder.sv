module select_adder (
	input  logic  [15:0] a, 
    input  logic  [15:0] b,
	input  logic         cin,
	
	output logic  [15:0] s,
	output logic         cout
);

	/* TODO
		*
		* Insert code here to implement a CSA adder.
		* Your code should be completly combinational (don't use always_ff or always_latch).
		* Feel free to create sub-modules or other files. */

//internal signals
logic C4, C4_0, C4_1, C8, C8_0, C8_1, C12, C12_0, C12_1, C16_0, C16_1;
logic [3:0] S4_0, S4_1, S8_0, S8_1, S12_0, S12_1;

ADDER4 block0( .A(a[3:0]), .B(b[3:0]), .c_in(cin), .S(s[3:0]), .c_out(C4));

ADDER4 block1_0( .A(a[7:4]), .B(b[7:4]), .c_in(1'b0), .S(S4_0), .c_out(C8_0));
ADDER4 block1_1(.A(a[7:4]), .B(b[7:4]), .c_in(1'b1), .S(S4_1), .c_out(C8_1));

ADDER4 block2_0(.A(a[11:8]), .B(b[11:8]), .c_in(1'b0), .S(S8_0), .c_out(C12_0));
ADDER4 block2_1(.A(a[11:8]), .B(b[11:8]), .c_in(1'b1), .S(S8_1), .c_out(C12_1));

ADDER4 block3_0(.A(a[15:12]), .B(b[15:12]), .c_in(1'b0), .S(S12_0), .c_out(C16_0));
ADDER4 block3_1(.A(a[15:12]), .B(b[15:12]), .c_in(1'b1), .S(S12_1), .c_out(C16_1));

//block 1 select
assign s[7:4] = (C4) ? S4_1 : S4_0;
assign C8 = (C4) ? C8_1 : C8_0;

//block 2 select
assign s[11:8] = (C8) ? S8_1 : S8_0;
assign C12 = (C8) ? C12_1 : C12_0;

//block 3 select
assign s[15:12] = (C12) ? S12_1 : S12_0;
assign cout  = (C12) ? C16_1 : C16_0;



endmodule
