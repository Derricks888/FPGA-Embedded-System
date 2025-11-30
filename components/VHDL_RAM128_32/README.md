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
