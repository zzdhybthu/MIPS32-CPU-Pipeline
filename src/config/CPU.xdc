set_property -dict {PACKAGE_PIN R4  IOSTANDARD LVCMOS33} [get_ports sysclk]
set_property -dict {PACKAGE_PIN B22  IOSTANDARD LVCMOS33} [get_ports rst]

#create_clock -period 10.000 -name CLK -waveform {0.000 5.000} [get_ports sysclk]

set_property -dict {PACKAGE_PIN N2 IOSTANDARD LVCMOS33} [get_ports {Seg[0]}]
set_property -dict {PACKAGE_PIN P5 IOSTANDARD LVCMOS33} [get_ports {Seg[1]}]
set_property -dict {PACKAGE_PIN V5 IOSTANDARD LVCMOS33} [get_ports {Seg[2]}]
set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports {Seg[3]}]
set_property -dict {PACKAGE_PIN T5 IOSTANDARD LVCMOS33} [get_ports {Seg[4]}]
set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS33} [get_ports {Seg[5]}]
set_property -dict {PACKAGE_PIN W4 IOSTANDARD LVCMOS33} [get_ports {Seg[6]}]

set_property -dict {PACKAGE_PIN Y3  IOSTANDARD LVCMOS33} [get_ports {Sel[0]}]
set_property -dict {PACKAGE_PIN R1  IOSTANDARD LVCMOS33} [get_ports {Sel[1]}]
set_property -dict {PACKAGE_PIN P2  IOSTANDARD LVCMOS33} [get_ports {Sel[2]}]
set_property -dict {PACKAGE_PIN M2  IOSTANDARD LVCMOS33} [get_ports {Sel[3]}]

set_property -dict {PACKAGE_PIN V3 IOSTANDARD LVCMOS33} [get_ports Dot]
