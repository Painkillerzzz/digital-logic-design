# 100M Input Clock
set_property -dict {PACKAGE_PIN K4 IOSTANDARD LVCMOS33} [get_ports clk_100m]

# Push Buttons: CLK, RST, KEY1-4
set_property -dict {PACKAGE_PIN AB11 IOSTANDARD LVCMOS33} [get_ports btn_clk]
set_property -dict {PACKAGE_PIN AA11 IOSTANDARD LVCMOS33} [get_ports btn_rst]
set_property -dict {PACKAGE_PIN Y11 IOSTANDARD LVCMOS33} [get_ports btn_push[0]]
set_property -dict {PACKAGE_PIN AB10 IOSTANDARD LVCMOS33} [get_ports btn_push[1]]
set_property -dict {PACKAGE_PIN AA10 IOSTANDARD LVCMOS33} [get_ports btn_push[2]]
set_property -dict {PACKAGE_PIN AA9 IOSTANDARD LVCMOS33} [get_ports btn_push[3]]

# 16 DIP switches
set_property -dict {PACKAGE_PIN AA14 IOSTANDARD LVCMOS33} [get_ports dip_sw[0]]
set_property -dict {PACKAGE_PIN Y14 IOSTANDARD LVCMOS33} [get_ports dip_sw[1]]
set_property -dict {PACKAGE_PIN AA13 IOSTANDARD LVCMOS33} [get_ports dip_sw[2]]
set_property -dict {PACKAGE_PIN AB13 IOSTANDARD LVCMOS33} [get_ports dip_sw[3]]
set_property -dict {PACKAGE_PIN Y13 IOSTANDARD LVCMOS33} [get_ports dip_sw[4]]
set_property -dict {PACKAGE_PIN AB12 IOSTANDARD LVCMOS33} [get_ports dip_sw[5]]
set_property -dict {PACKAGE_PIN W12 IOSTANDARD LVCMOS33} [get_ports dip_sw[6]]
set_property -dict {PACKAGE_PIN Y12 IOSTANDARD LVCMOS33} [get_ports dip_sw[7]]
set_property -dict {PACKAGE_PIN Y18 IOSTANDARD LVCMOS33} [get_ports dip_sw[8]]
set_property -dict {PACKAGE_PIN AB17 IOSTANDARD LVCMOS33} [get_ports dip_sw[9]]
set_property -dict {PACKAGE_PIN Y17 IOSTANDARD LVCMOS33} [get_ports dip_sw[10]]
set_property -dict {PACKAGE_PIN AB16 IOSTANDARD LVCMOS33} [get_ports dip_sw[11]]
set_property -dict {PACKAGE_PIN AA16 IOSTANDARD LVCMOS33} [get_ports dip_sw[12]]
set_property -dict {PACKAGE_PIN Y16 IOSTANDARD LVCMOS33} [get_ports dip_sw[13]]
set_property -dict {PACKAGE_PIN AB15 IOSTANDARD LVCMOS33} [get_ports dip_sw[14]]
set_property -dict {PACKAGE_PIN AA15 IOSTANDARD LVCMOS33} [get_ports dip_sw[15]]

# 32 LEDs
set_property -dict {PACKAGE_PIN D22 IOSTANDARD LVCMOS33} [get_ports led_bit[0]]
set_property -dict {PACKAGE_PIN C22 IOSTANDARD LVCMOS33} [get_ports led_bit[1]]
set_property -dict {PACKAGE_PIN B22 IOSTANDARD LVCMOS33} [get_ports led_bit[2]]
set_property -dict {PACKAGE_PIN B21 IOSTANDARD LVCMOS33} [get_ports led_bit[3]]
set_property -dict {PACKAGE_PIN A21 IOSTANDARD LVCMOS33} [get_ports led_bit[4]]
set_property -dict {PACKAGE_PIN C20 IOSTANDARD LVCMOS33} [get_ports led_bit[5]]
set_property -dict {PACKAGE_PIN B20 IOSTANDARD LVCMOS33} [get_ports led_bit[6]]
set_property -dict {PACKAGE_PIN A20 IOSTANDARD LVCMOS33} [get_ports led_bit[7]]
set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVCMOS33} [get_ports led_com[0]]
set_property -dict {PACKAGE_PIN G20 IOSTANDARD LVCMOS33} [get_ports led_com[1]]
set_property -dict {PACKAGE_PIN F21 IOSTANDARD LVCMOS33} [get_ports led_com[2]]
set_property -dict {PACKAGE_PIN E22 IOSTANDARD LVCMOS33} [get_ports led_com[3]]

# 7-Segment Display
set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33} [get_ports dpy_segment[1]]
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS33} [get_ports dpy_segment[6]]
set_property -dict {PACKAGE_PIN E14 IOSTANDARD LVCMOS33} [get_ports dpy_segment[2]]
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports dpy_segment[7]]
set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS33} [get_ports dpy_segment[5]]
set_property -dict {PACKAGE_PIN E13 IOSTANDARD LVCMOS33} [get_ports dpy_segment[3]]
set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVCMOS33} [get_ports dpy_segment[0]]
set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS33} [get_ports dpy_segment[4]]
set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS33} [get_ports dpy_digit[0]]
set_property -dict {PACKAGE_PIN B17 IOSTANDARD LVCMOS33} [get_ports dpy_digit[1]]
set_property -dict {PACKAGE_PIN B16 IOSTANDARD LVCMOS33} [get_ports dpy_digit[2]]
set_property -dict {PACKAGE_PIN B15 IOSTANDARD LVCMOS33} [get_ports dpy_digit[3]]
set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports dpy_digit[4]]
set_property -dict {PACKAGE_PIN C18 IOSTANDARD LVCMOS33} [get_ports dpy_digit[5]]
set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports dpy_digit[6]]
set_property -dict {PACKAGE_PIN A19 IOSTANDARD LVCMOS33} [get_ports dpy_digit[7]]

# PS2 Mouse
# set_property -dict {PACKAGE_PIN H13 IOSTANDARD LVCMOS33} [get_ports ps2_mouse_clk]
# set_property -dict {PACKAGE_PIN G13 IOSTANDARD LVCMOS33} [get_ports ps2_mouse_data]

# PS2 Keyboard
# set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports ps2_keyboard_clk]
# set_property -dict {PACKAGE_PIN H14 IOSTANDARD LVCMOS33} [get_ports ps2_keyboard_data]

# LAB UART - USB
# set_property -dict {PACKAGE_PIN D17 IOSTANDARD LVCMOS33} [get_ports uart_txd]
# set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS33} [get_ports uart_rxd]

# DDR3 SDRAM
# set_property INTERNAL_VREF 0.675 [get_iobanks 34]
# set_property PACKAGE_PIN V7 [get_ports ddr3_addr[0]]
# set_property PACKAGE_PIN AA3 [get_ports ddr3_addr[1]]
# set_property PACKAGE_PIN U5 [get_ports ddr3_addr[2]]
# set_property PACKAGE_PIN T6 [get_ports ddr3_addr[3]]
# set_property PACKAGE_PIN AB7 [get_ports ddr3_addr[4]]
# set_property PACKAGE_PIN R6 [get_ports ddr3_addr[5]]
# set_property PACKAGE_PIN AB2 [get_ports ddr3_addr[6]]
# set_property PACKAGE_PIN W6 [get_ports ddr3_addr[7]]
# set_property PACKAGE_PIN AB1 [get_ports ddr3_addr[8]]
# set_property PACKAGE_PIN Y4 [get_ports ddr3_addr[9]]
# set_property PACKAGE_PIN AB5 [get_ports ddr3_addr[10]]
# set_property PACKAGE_PIN AB3 [get_ports ddr3_addr[11]]
# set_property PACKAGE_PIN AB6 [get_ports ddr3_addr[12]]
# set_property PACKAGE_PIN AA4 [get_ports ddr3_addr[13]]
# set_property PACKAGE_PIN AA1 [get_ports ddr3_addr[14]]
# set_property PACKAGE_PIN Y6 [get_ports ddr3_addr[15]]
# set_property PACKAGE_PIN U6 [get_ports ddr3_ba[0]]
# set_property PACKAGE_PIN AA6 [get_ports ddr3_ba[1]]
# set_property PACKAGE_PIN V5 [get_ports ddr3_ba[2]]
# set_property PACKAGE_PIN V8 [get_ports ddr3_ck_n[0]]
# set_property PACKAGE_PIN V9 [get_ports ddr3_ck_p[0]]
# set_property PACKAGE_PIN AA5 [get_ports ddr3_cke[0]]
# set_property PACKAGE_PIN Y2 [get_ports ddr3_dm[0]]
# set_property PACKAGE_PIN U2 [get_ports ddr3_dq[0]]
# set_property PACKAGE_PIN W2 [get_ports ddr3_dq[1]]
# set_property PACKAGE_PIN U1 [get_ports ddr3_dq[2]]
# set_property PACKAGE_PIN Y1 [get_ports ddr3_dq[3]]
# set_property PACKAGE_PIN V3 [get_ports ddr3_dq[4]]
# set_property PACKAGE_PIN W1 [get_ports ddr3_dq[5]]
# set_property PACKAGE_PIN T1 [get_ports ddr3_dq[6]]
# set_property PACKAGE_PIN V2 [get_ports ddr3_dq[7]]
# set_property PACKAGE_PIN R2 [get_ports ddr3_dqs_n[0]]
# set_property PACKAGE_PIN R3 [get_ports ddr3_dqs_p[0]]
# set_property PACKAGE_PIN W5 [get_ports ddr3_cas_n]
# set_property PACKAGE_PIN T5 [get_ports ddr3_cs_n[0]]
# set_property PACKAGE_PIN W4 [get_ports ddr3_ras_n]
# set_property PACKAGE_PIN R4 [get_ports ddr3_reset_n]
# set_property PACKAGE_PIN V4 [get_ports ddr3_we_n]
# set_property PACKAGE_PIN T4 [get_ports ddr3_odt[0]]

# Base RAM (SRAM)
# set_property -dict {PACKAGE_PIN T19 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[0]]
# set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[1]]
# set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[10]]
# set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[11]]
# set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[12]]
# set_property -dict {PACKAGE_PIN L15 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[13]]
# set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[14]]
# set_property -dict {PACKAGE_PIN W19 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[15]]
# set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[16]]
# set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[17]]
# set_property -dict {PACKAGE_PIN V19 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[18]]
# set_property -dict {PACKAGE_PIN V18 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[19]]
# set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[2]]
# set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[3]]
# set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[4]]
# set_property -dict {PACKAGE_PIN H19 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[5]]
# set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[6]]
# set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[7]]
# set_property -dict {PACKAGE_PIN J19 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[8]]
# set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33} [get_ports base_ram_addr[9]]
# set_property -dict {PACKAGE_PIN V20 IOSTANDARD LVCMOS33} [get_ports base_ram_data[0]]
# set_property -dict {PACKAGE_PIN V22 IOSTANDARD LVCMOS33} [get_ports base_ram_data[1]]
# set_property -dict {PACKAGE_PIN U20 IOSTANDARD LVCMOS33} [get_ports base_ram_data[2]]
# set_property -dict {PACKAGE_PIN U21 IOSTANDARD LVCMOS33} [get_ports base_ram_data[3]]
# set_property -dict {PACKAGE_PIN T20 IOSTANDARD LVCMOS33} [get_ports base_ram_data[4]]
# set_property -dict {PACKAGE_PIN T21 IOSTANDARD LVCMOS33} [get_ports base_ram_data[5]]
# set_property -dict {PACKAGE_PIN R19 IOSTANDARD LVCMOS33} [get_ports base_ram_data[6]]
# set_property -dict {PACKAGE_PIN R21 IOSTANDARD LVCMOS33} [get_ports base_ram_data[7]]
# set_property -dict {PACKAGE_PIN L21 IOSTANDARD LVCMOS33} [get_ports base_ram_data[8]]
# set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVCMOS33} [get_ports base_ram_data[9]]
# set_property -dict {PACKAGE_PIN K22 IOSTANDARD LVCMOS33} [get_ports base_ram_data[10]]
# set_property -dict {PACKAGE_PIN K21 IOSTANDARD LVCMOS33} [get_ports base_ram_data[11]]
# set_property -dict {PACKAGE_PIN K19 IOSTANDARD LVCMOS33} [get_ports base_ram_data[12]]
# set_property -dict {PACKAGE_PIN J22 IOSTANDARD LVCMOS33} [get_ports base_ram_data[13]]
# set_property -dict {PACKAGE_PIN J21 IOSTANDARD LVCMOS33} [get_ports base_ram_data[14]]
# set_property -dict {PACKAGE_PIN J20 IOSTANDARD LVCMOS33} [get_ports base_ram_data[15]]
# set_property -dict {PACKAGE_PIN P20 IOSTANDARD LVCMOS33} [get_ports base_ram_data[16]]
# set_property -dict {PACKAGE_PIN P21 IOSTANDARD LVCMOS33} [get_ports base_ram_data[17]]
# set_property -dict {PACKAGE_PIN P22 IOSTANDARD LVCMOS33} [get_ports base_ram_data[18]]
# set_property -dict {PACKAGE_PIN N20 IOSTANDARD LVCMOS33} [get_ports base_ram_data[19]]
# set_property -dict {PACKAGE_PIN N22 IOSTANDARD LVCMOS33} [get_ports base_ram_data[20]]
# set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS33} [get_ports base_ram_data[21]]
# set_property -dict {PACKAGE_PIN M21 IOSTANDARD LVCMOS33} [get_ports base_ram_data[22]]
# set_property -dict {PACKAGE_PIN M22 IOSTANDARD LVCMOS33} [get_ports base_ram_data[23]]
# set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports base_ram_data[24]]
# set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS33} [get_ports base_ram_data[25]]
# set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports base_ram_data[26]]
# set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports base_ram_data[27]]
# set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33} [get_ports base_ram_data[28]]
# set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS33} [get_ports base_ram_data[29]]
# set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports base_ram_data[30]]
# set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS33} [get_ports base_ram_data[31]]
# set_property -dict {PACKAGE_PIN H22 IOSTANDARD LVCMOS33} [get_ports base_ram_be_n[0]]
# set_property -dict {PACKAGE_PIN G22 IOSTANDARD LVCMOS33} [get_ports base_ram_be_n[1]]
# set_property -dict {PACKAGE_PIN M16 IOSTANDARD LVCMOS33} [get_ports base_ram_be_n[2]]
# set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports base_ram_be_n[3]]
# set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports base_ram_ce_n]
# set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS33} [get_ports base_ram_oe_n]
# set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports base_ram_we_n]



# # PMOD1 (customize as needed)
# set_property -dict {PACKAGE_PIN H2 IOSTANDARD LVCMOS33} [get_ports pmod1_io[0]]
# set_property -dict {PACKAGE_PIN G1 IOSTANDARD LVCMOS33} [get_ports pmod1_io[1]]
# set_property -dict {PACKAGE_PIN F1 IOSTANDARD LVCMOS33} [get_ports pmod1_io[2]]
# set_property -dict {PACKAGE_PIN E1 IOSTANDARD LVCMOS33} [get_ports pmod1_io[3]]
# set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports pmod1_io[4]]
# set_property -dict {PACKAGE_PIN J1 IOSTANDARD LVCMOS33} [get_ports pmod1_io[5]]
# set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS33} [get_ports pmod1_io[6]]
# set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports pmod1_io[7]]

# # PMOD2 (customize as needed)
# set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports pmod2_io[0]]
# set_property -dict {PACKAGE_PIN K3 IOSTANDARD LVCMOS33} [get_ports pmod2_io[1]]
# set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports pmod2_io[2]]
# set_property -dict {PACKAGE_PIN K1 IOSTANDARD LVCMOS33} [get_ports pmod2_io[3]]
# set_property -dict {PACKAGE_PIN L3 IOSTANDARD LVCMOS33} [get_ports pmod2_io[4]]
# set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVCMOS33} [get_ports pmod2_io[5]]
# set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVCMOS33} [get_ports pmod2_io[6]]
# set_property -dict {PACKAGE_PIN M3 IOSTANDARD LVCMOS33} [get_ports pmod2_io[7]]

# # PMOD3 (customize as needed)
# set_property -dict {PACKAGE_PIN L4 IOSTANDARD LVCMOS33} [get_ports pmod3_io[0]]
# set_property -dict {PACKAGE_PIN M5 IOSTANDARD LVCMOS33} [get_ports pmod3_io[1]]
# set_property -dict {PACKAGE_PIN M6 IOSTANDARD LVCMOS33} [get_ports pmod3_io[2]]
# set_property -dict {PACKAGE_PIN N4 IOSTANDARD LVCMOS33} [get_ports pmod3_io[3]]
# set_property -dict {PACKAGE_PIN L6 IOSTANDARD LVCMOS33} [get_ports pmod3_io[4]]
# set_property -dict {PACKAGE_PIN K6 IOSTANDARD LVCMOS33} [get_ports pmod3_io[5]]
# set_property -dict {PACKAGE_PIN J5 IOSTANDARD LVCMOS33} [get_ports pmod3_io[6]]
# set_property -dict {PACKAGE_PIN J6 IOSTANDARD LVCMOS33} [get_ports pmod3_io[7]]

# # PMOD4 (customize as needed)
# set_property -dict {PACKAGE_PIN AA19 IOSTANDARD LVCMOS33} [get_ports pmod4_io[0]]
# set_property -dict {PACKAGE_PIN Y19 IOSTANDARD LVCMOS33} [get_ports pmod4_io[1]]
# set_property -dict {PACKAGE_PIN AB18 IOSTANDARD LVCMOS33} [get_ports pmod4_io[2]]
# set_property -dict {PACKAGE_PIN AA18 IOSTANDARD LVCMOS33} [get_ports pmod4_io[3]]
# set_property -dict {PACKAGE_PIN AA20 IOSTANDARD LVCMOS33} [get_ports pmod4_io[4]]
# set_property -dict {PACKAGE_PIN AB20 IOSTANDARD LVCMOS33} [get_ports pmod4_io[5]]
# set_property -dict {PACKAGE_PIN AA21 IOSTANDARD LVCMOS33} [get_ports pmod4_io[6]]
# set_property -dict {PACKAGE_PIN AB21 IOSTANDARD LVCMOS33} [get_ports pmod4_io[7]]

# # PMOD5 (customize as needed)
# set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports pmod5_io[0]]
# set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports pmod5_io[1]]
# set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33} [get_ports pmod5_io[2]]
# set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33} [get_ports pmod5_io[3]]
# set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports pmod5_io[4]]
# set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports pmod5_io[5]]
# set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports pmod5_io[6]]
# set_property -dict {PACKAGE_PIN W11 IOSTANDARD LVCMOS33} [get_ports pmod5_io[7]]

# HDMI TMDS
# set_property -dict {PACKAGE_PIN C15 IOSTANDARD TMDS_33} [get_ports hdmi_tmds_n[0]]
# set_property -dict {PACKAGE_PIN C14 IOSTANDARD TMDS_33} [get_ports hdmi_tmds_p[0]]
# set_property -dict {PACKAGE_PIN A14 IOSTANDARD TMDS_33} [get_ports hdmi_tmds_n[1]]
# set_property -dict {PACKAGE_PIN A13 IOSTANDARD TMDS_33} [get_ports hdmi_tmds_p[1]]
# set_property -dict {PACKAGE_PIN B13 IOSTANDARD TMDS_33} [get_ports hdmi_tmds_n[2]]
# set_property -dict {PACKAGE_PIN C13 IOSTANDARD TMDS_33} [get_ports hdmi_tmds_p[2]]
# set_property -dict {PACKAGE_PIN A16 IOSTANDARD TMDS_33} [get_ports hdmi_tmds_c_n]
# set_property -dict {PACKAGE_PIN A15 IOSTANDARD TMDS_33} [get_ports hdmi_tmds_c_p]

# RGMII PHY
# set_property -dict {PACKAGE_PIN H3 IOSTANDARD LVCMOS33} [get_ports rgmii_rx_clk]
# set_property -dict {PACKAGE_PIN F3 IOSTANDARD LVCMOS33} [get_ports rgmii_rx_ctl]
# set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports rgmii_rx_data[0]]
# set_property -dict {PACKAGE_PIN F4 IOSTANDARD LVCMOS33} [get_ports rgmii_rx_data[1]]
# set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS33} [get_ports rgmii_rx_data[2]]
# set_property -dict {PACKAGE_PIN G3 IOSTANDARD LVCMOS33} [get_ports rgmii_rx_data[3]]
# set_property -dict {PACKAGE_PIN B1 IOSTANDARD LVCMOS33} [get_ports rgmii_tx_ctl]
# set_property -dict {PACKAGE_PIN E2 IOSTANDARD LVCMOS33} [get_ports rgmii_tx_clk]
# set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports rgmii_tx_data[0]]
# set_property -dict {PACKAGE_PIN D1 IOSTANDARD LVCMOS33} [get_ports rgmii_tx_data[1]]
# set_property -dict {PACKAGE_PIN D2 IOSTANDARD LVCMOS33} [get_ports rgmii_tx_data[2]]
# set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports rgmii_tx_data[3]]
# set_property -dict {PACKAGE_PIN A1 IOSTANDARD LVCMOS33} [get_ports rgmii_mdio]
# set_property -dict {PACKAGE_PIN B2 IOSTANDARD LVCMOS33} [get_ports rgmii_mdc]
# set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports rgmii_clk125]

# RS232
# set_property -dict {PACKAGE_PIN E16 IOSTANDARD LVCMOS33} [get_ports rs232_rts]
# set_property -dict {PACKAGE_PIN F16 IOSTANDARD LVCMOS33} [get_ports rs232_txd]
# set_property -dict {PACKAGE_PIN D15 IOSTANDARD LVCMOS33} [get_ports rs232_rxd]
# set_property -dict {PACKAGE_PIN D16 IOSTANDARD LVCMOS33} [get_ports rs232_cts]

# QSPI NOR Flash
# set_property -dict {PACKAGE_PIN Y21 IOSTANDARD LVCMOS33} [get_ports qspi_clk]
# set_property -dict {PACKAGE_PIN AB22 IOSTANDARD LVCMOS33} [get_ports qspi_io[0]]
# set_property -dict {PACKAGE_PIN W21 IOSTANDARD LVCMOS33} [get_ports qspi_io[1]]
# set_property -dict {PACKAGE_PIN W22 IOSTANDARD LVCMOS33} [get_ports qspi_io[2]]
# set_property -dict {PACKAGE_PIN Y22 IOSTANDARD LVCMOS33} [get_ports qspi_io[3]]
# set_property -dict {PACKAGE_PIN W20 IOSTANDARD LVCMOS33} [get_ports qspi_nss]

# QSPI PSRAM
# set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports psram_clk]
# set_property -dict {PACKAGE_PIN R14 IOSTANDARD LVCMOS33} [get_ports psram_io[0]]
# set_property -dict {PACKAGE_PIN W17 IOSTANDARD LVCMOS33} [get_ports psram_io[1]]
# set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports psram_io[2]]
# set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports psram_io[3]]
# set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports psram_nss]

# SD Card CD and WP
# set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports sd_cd]
# set_property -dict {PACKAGE_PIN D19 IOSTANDARD LVCMOS33} [get_ports sd_wp]

# SD Card (SD mode)
# set_property -dict {PACKAGE_PIN F18 IOSTANDARD LVCMOS33} [get_ports sd_clk]
# set_property -dict {PACKAGE_PIN F19 IOSTANDARD LVCMOS33} [get_ports sd_cmd]
# set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33} [get_ports sd_dat[0]]
# set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports sd_dat[1]]
# set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports sd_dat[2]]
# set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS33} [get_ports sd_dat[3]]

# SD Card (SPI mode)
# set_property -dict {PACKAGE_PIN F18 IOSTANDARD LVCMOS33} [get_ports sd_sclk]  # SD CLK
# set_property -dict {PACKAGE_PIN F19 IOSTANDARD LVCMOS33} [get_ports sd_mosi]  # SD CMD
# set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33} [get_ports sd_miso]  # SD DAT0
# set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS33} [get_ports sd_cs]    # SD DAT3
