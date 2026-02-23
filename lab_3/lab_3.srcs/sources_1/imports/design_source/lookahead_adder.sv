module lookahead_adder (
	input  logic  [15:0] a, 
    input  logic  [15:0] b,
	input  logic         cin,
	
	output logic  [15:0] s,
	output logic         cout
);

	/* TODO
		*
		* Insert code here to implement a CLA adder.
		* Your code should be completly combinational (don't use always_ff or always_latch).
		* Feel free to create sub-modules or other files. */
	//internal GG PG
	logic PG0, PG4, PG8, PG12;
	logic GG0, GG4, GG8, GG12;
	logic C4, C8, C12, C16;

	//instantiation of 4 bit cla
	cla_4 cla0 (.a(a[3:0]), .b(b[3:0]), .cin(cin), .s(s[3:0]), .cout(), .PG(PG0), .GG(GG0));
	assign C4  = GG0 | (PG0 & cin);

	cla_4 cla1 (.a(a[7:4]), .b(b[7:4]), .cin(C4), .s(s[7:4]), .cout(), .PG(PG4), .GG(GG4));
	assign C8  = GG4 | (GG0 & PG4) | (cin & PG0 & PG4);

	cla_4 cla2 (.a(a[11:8]), .b(b[11:8]), .cin(C8), .s(s[11:8]), .cout(), .PG(PG8), .GG(GG8));
	assign C12 = GG8 | (GG4 & PG8) | (GG0 & PG8 & PG4) | (cin & PG0 & PG4 & PG8);

	cla_4 cla3 (.a(a[15:12]), .b(b[15:12]), .cin(C12), .s(s[15:12]), .cout(), .PG(PG12), .GG(GG12));
	assign C16 = GG12 | (GG8 & PG12) | (GG4 & PG12 & PG8) | (GG0 & PG12 & PG8 & PG4) | (cin & PG0 & PG4 & PG8 & PG12);

	assign cout = C16;


endmodule
