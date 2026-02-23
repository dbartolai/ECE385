module ripple_adder (
	input  logic  [15:0] a, 
    input  logic  [15:0] b,
	input  logic         cin,
	
	output logic  [15:0] s,
	output logic         cout
);

	/* TODO
		*
		* Insert code here to implement a ripple adder.
		* Your code should be completly combinational (don't use always_ff or always_latch).
		* Feel free to create sub-modules or other files. */

	logic c4, c8, c12;

	ADDER4 RA0(.A(a[3:0]), .B(b[3:0]), .c_in(cin), 	.S(s[3:0]), 	.c_out(c4));
	ADDER4 RA1(.A(a[7:4]), 	.B(b[7:4]), .c_in(c4), 	.S(s[7:4]), 	.c_out(c8));
	ADDER4 RA2(.A(a[11:8]), .B(b[11:8]), .c_in(c8), .S(s[11:8]), 	.c_out(c12));
	ADDER4 RA3(.A(a[15:12]), .B(b[15:12]), 	.c_in(c12), .S(s[15:12]), .c_out(cout));

endmodule
