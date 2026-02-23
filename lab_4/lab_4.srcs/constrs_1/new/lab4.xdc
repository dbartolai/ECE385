############################################
## CLOCK (50 MHz On-Board Oscillator)
############################################
set_property PACKAGE_PIN N15 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -name sys_clk -period 20.000 [get_ports clk]


############################################
## PUSH BUTTONS
############################################

# Reset_Load_Clear (BTN0)
set_property PACKAGE_PIN J2 [get_ports reset]
set_property IOSTANDARD LVCMOS25 [get_ports reset]

# Run (BTN1)
set_property PACKAGE_PIN J1 [get_ports run]
set_property IOSTANDARD LVCMOS25 [get_ports run]


############################################
## SWITCHES (S[7:0])
############################################
set_property PACKAGE_PIN G1 [get_ports {S[0]}]
set_property PACKAGE_PIN F2 [get_ports {S[1]}]
set_property PACKAGE_PIN F1 [get_ports {S[2]}]
set_property PACKAGE_PIN E2 [get_ports {S[3]}]
set_property PACKAGE_PIN E1 [get_ports {S[4]}]
set_property PACKAGE_PIN D2 [get_ports {S[5]}]
set_property PACKAGE_PIN D1 [get_ports {S[6]}]
set_property PACKAGE_PIN C2 [get_ports {S[7]}]

set_property IOSTANDARD LVCMOS25 [get_ports {S[*]}]


############################################
## Bval LEDs (LED0-LED7)
############################################
set_property PACKAGE_PIN C13 [get_ports {Bval[0]}]
set_property PACKAGE_PIN C14 [get_ports {Bval[1]}]
set_property PACKAGE_PIN D14 [get_ports {Bval[2]}]
set_property PACKAGE_PIN D15 [get_ports {Bval[3]}]
set_property PACKAGE_PIN D16 [get_ports {Bval[4]}]
set_property PACKAGE_PIN F18 [get_ports {Bval[5]}]
set_property PACKAGE_PIN E17 [get_ports {Bval[6]}]
set_property PACKAGE_PIN D17 [get_ports {Bval[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {Bval[*]}]


############################################
## Aval LEDs (LED8-LED15)
############################################
set_property PACKAGE_PIN C17 [get_ports {Aval[0]}]
set_property PACKAGE_PIN B18 [get_ports {Aval[1]}]
set_property PACKAGE_PIN A17 [get_ports {Aval[2]}]
set_property PACKAGE_PIN B17 [get_ports {Aval[3]}]
set_property PACKAGE_PIN C18 [get_ports {Aval[4]}]
set_property PACKAGE_PIN D18 [get_ports {Aval[5]}]
set_property PACKAGE_PIN E18 [get_ports {Aval[6]}]
set_property PACKAGE_PIN G17 [get_ports {Aval[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {Aval[*]}]


############################################
## Xval (RGB0_R)
############################################
set_property PACKAGE_PIN C9 [get_ports Xval]
set_property IOSTANDARD LVCMOS33 [get_ports Xval]


############################################
## 7-Segment Display Grid
############################################
set_property PACKAGE_PIN G6 [get_ports {hex_grid[0]}]
set_property PACKAGE_PIN H6 [get_ports {hex_grid[1]}]
set_property PACKAGE_PIN C3 [get_ports {hex_grid[2]}]
set_property PACKAGE_PIN B3 [get_ports {hex_grid[3]}]

set_property IOSTANDARD LVCMOS25 [get_ports {hex_grid[*]}]


############################################
## 7-Segment Display Segments
############################################
set_property PACKAGE_PIN E6 [get_ports {hex_seg[0]}]
set_property PACKAGE_PIN B4 [get_ports {hex_seg[1]}]
set_property PACKAGE_PIN D5 [get_ports {hex_seg[2]}]
set_property PACKAGE_PIN C5 [get_ports {hex_seg[3]}]
set_property PACKAGE_PIN D7 [get_ports {hex_seg[4]}]
set_property PACKAGE_PIN D6 [get_ports {hex_seg[5]}]
set_property PACKAGE_PIN C4 [get_ports {hex_seg[6]}]
set_property PACKAGE_PIN B5 [get_ports {hex_seg[7]}]

set_property IOSTANDARD LVCMOS25 [get_ports {hex_seg[*]}]
