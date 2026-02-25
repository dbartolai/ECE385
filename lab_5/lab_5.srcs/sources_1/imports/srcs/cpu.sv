//------------------------------------------------------------------------------
// Company: 		 UIUC ECE Dept.
// Engineer:		 Stephen Kempf
//
// Create Date:    
// Design Name:    ECE 385 Given Code - SLC-3 core
// Module Name:    SLC3
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 09-22-2015 
//    Revised 06-09-2020
//	  Revised 03-02-2021
//    Xilinx vivado
//    Revised 07-25-2023 
//    Revised 12-29-2023
//    Revised 09-25-2024
//------------------------------------------------------------------------------

module cpu (
    input   logic        clk,
    input   logic        reset,

    input   logic        run_i,
    input   logic        continue_i,
    output  logic [15:0] hex_display_debug,
    output  logic [15:0] led_o,
   
    input   logic [15:0] mem_rdata,
    output  logic [15:0] mem_wdata,
    output  logic [15:0] mem_addr,
    output  logic        mem_mem_ena,
    output  logic        mem_wr_ena
);


// Internal connections, follow the datapath block diagram and add the additional needed signals
logic ld_mar; 
logic ld_mdr; 
logic ld_ir; 
logic ld_pc; 
logic ld_led;

logic gate_pc;
logic gate_mdr;

logic [1:0] pcmux;

logic [15:0] mar; 
logic [15:0] mdr;
logic [15:0] ir;
logic [15:0] pc;
logic ben;

//required mux signals

logic [15:0] bus;
logic gate_alu;
logic gate_marmux;
logic [15:0] alu_out;
logic [15:0] marmux_out;
assign alu_out    = 16'h0000;  //placeholder for Week 2
assign marmux_out = 16'h0000;  //placeholder for Week 2

//cpu busMUX
always_comb begin
    if (gate_pc)
        bus = pc;
    else if (gate_mdr)
        bus = mdr;
    else if (gate_alu)
        bus = alu_out;
    else if (gate_marmux)
        bus = marmux_out; 
    else
        bus = 16'h0000;
end


//PCMUX derived from pcmux
logic [15:0] pcmux_out;
always_comb begin
    case (pcmux)
        2'b00: pcmux_out = pc + 1;

        //week 2 cases add later
        default: pcmux_out = pc + 1;

    endcase

end



assign mem_addr = mar;
assign mem_wdata = mdr;


//MDR mux
logic [15:0] mdr_in;
always_comb begin
    if (mem_mem_ena)
        mdr_in = mem_rdata;
    else
        mdr_in = bus;  
end

// State machine, you need to fill in the code here as well
// .* auto-infers module input/output connections which have the same name
// This can help visually condense modules with large instantiations, 
// but can also lead to confusing code if used too commonly
control cpu_control (
    .*
);


assign led_o = ir;
assign hex_display_debug = ir;

load_reg #(.DATA_WIDTH(16)) ir_reg (
    .clk    (clk),
    .reset  (reset),

    .load   (ld_ir),
    .data_i (bus),

    .data_q (ir)
);

load_reg #(.DATA_WIDTH(16)) pc_reg (
    .clk(clk),
    .reset(reset),

    .load(ld_pc),
    .data_i(pcmux_out),

    .data_q(pc)
);

//MAR
load_reg #(.DATA_WIDTH(16)) mar_reg (
    .clk(clk),
    .reset(reset),

    .load(ld_mar),
    .data_i(bus),

    .data_q(mar)
);

//MDR
load_reg #(.DATA_WIDTH(16)) mdr_reg (
    .clk(clk),
    .reset(reset),

    .load(ld_mdr),
    .data_i(mdr_in),

    .data_q(mdr)
);



endmodule