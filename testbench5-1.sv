module testbench5_1();

	timeunit 10ns;
	timeprecision 1ns;

	// CPU interface signals
	logic        clk;
	logic        reset;
	logic        run_i;
	logic        continue_i;
	logic [15:0] mem_rdata;
	logic [15:0] hex_display_debug;
	logic [15:0] led_o;
	logic [15:0] mem_wdata;
	logic [15:0] mem_addr;
	logic        mem_mem_ena;
	logic        mem_wr_ena;

	// Test value for MDR -> IR
	localparam logic [15:0] TEST_IR_VALUE = 16'hBEEF;

	// DUT
	cpu cpu0(.*);

	initial begin: CLOCK_INITIALIZATION
		clk = 1;
	end

	always begin: CLOCK_GENERATION
		#1 clk = ~clk;
	end

	initial begin: TEST_VECTORS
		reset = 1;
		run_i <= 0;
		continue_i <= 0;
		mem_rdata <= 16'h0000;

		repeat (3) @(posedge clk);
		reset <= 0;

		@(posedge clk);
		run_i <= 1;
		mem_rdata <= TEST_IR_VALUE;

		// After 2 cycles, state has been s_18: MAR = PC (0), PC = 1
		repeat (2) @(posedge clk);
		assert (mem_addr == 16'h0000) else $display("PC->MAR ERROR: mem_addr is %h, expected 0", mem_addr);

		// Run through s_33_1, s_33_2, s_33_3, s_35 -> pause_ir1 (5 more cycles)
		repeat (5) @(posedge clk);
		assert (led_o == TEST_IR_VALUE) else $display("MDR->IR ERROR: led_o is %h, expected %h", led_o, TEST_IR_VALUE);
		assert (hex_display_debug == TEST_IR_VALUE) else $display("MDR->IR ERROR: hex_display_debug is %h, expected %h", hex_display_debug, TEST_IR_VALUE);

		// Go to pause_ir2 then release continue so FSM returns to s_18 (PC=1 -> MAR)
		@(posedge clk);
		continue_i <= 1;
		repeat (2) @(posedge clk);
		continue_i <= 0;
		// After 2 cycles we have completed s_18 again: MAR = PC (1)
		repeat (2) @(posedge clk);
		assert (mem_addr == 16'h0001) else $display("PC increment ERROR: mem_addr is %h, expected 1", mem_addr);

		$display("All Lab 5 CPU tests passed.");
		$finish();
	end

endmodule
