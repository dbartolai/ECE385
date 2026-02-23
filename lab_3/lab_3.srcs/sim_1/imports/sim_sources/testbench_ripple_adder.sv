module testbench(); //even though the testbench doesn't create any hardware, it still needs to be a module

timeunit 10ns;  // This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic       Clk;
logic       Reset; 
//DUT Signals
logic [15:0] a, b, s;
logic       cin, cout;


//add DUT
ripple_adder ra16_dut (.*);


initial begin: CLOCK_INITIALIZATION
	Clk = 1'b1;
end 

// Toggle the clock
// #1 means wait for a delay of 1 timeunit, so simulation clock is 50 MHz technically 
// half of what it is on the FPGA board 

// Note: Since we do mostly behavioral simulations, timing is not accounted for in simulation, however
// this is important because we need to know what the time scale is for how long to run
// the simulation
always begin : CLOCK_GENERATION
	#1 Clk = ~Clk;
end

// Testing begins here
// The initial block is not synthesizable on an FPGA
// Everything happens sequentially inside an initial block
// as in a software program

// Note: Even though the testbench happens sequentially,
// it is recommended to use non-blocking assignments for most assignments because
// we do not want any dependencies to arise between different assignments in the 
// same simulation timestep. The exception is for reset, which we want to make sure
// happens first. 
initial begin: TEST_VECTORS
	Reset = 1;		// Toggle Reset (use blocking operator), because we want to have this happen 'first'
	#10.1 Reset = 0;
	
	a = 16'h1234;
	b = 16'h5678;

	
	$finish(); //this task will end the simulation if the Vivado settings are properly configured

end
endmodule
