# VHDL_RAM128_32

A reusable, synthesizable 128×32-bit RAM module written in VHDL.
Includes RTL, testbench, ModelSim simulation scripts, and documentation.

## Features
- 128-word × 32-bit synchronous RAM
- Synchronous write, synchronous/asynchronous read
- Fully synthesizable on Intel/Xilinx FPGAs
- Testbench with read/write verification
- Simulation-ready using ModelSim or GHDL

## Directory Structure
components/VHDL_RAM128_32/
│
├── rtl/       # RTL source (ram128x32.vhd)
├── tb/        # Testbench files
├── sim/       # Simulation scripts
└── docs/      # Waveforms, screenshots, notes
# Usage

To use the RAM module in an FPGA design:

u_ram : entity work.ram128x32
    port map (
        clk     => clk,
        we      => write_enable,
        addr    => address,
        din     => data_in,
        dout    => data_out
    );
Simply include ram128x32.vhd in your Quartus/Vivado project and instantiate as shown.
# Simulation (ModelSim / QuestaSim)

You can run the included automated testbench using:

# Command-line simulation

cd components/VHDL_RAM128_32/sim
vsim -do run.do

# Alternative TCL-based simulation
vsim -c -do vsim.tcl

#  What the simulation does

1. Writes random values to memory

2. Reads them back

3. Checks correctness

4. Displays signals in waveform viewer
