# 📘 BCD Adder (Binary-Coded Decimal Adder)
### DE10-Lite FPGA Implementation

This project implements a **Binary-Coded Decimal (BCD) adder** on the Intel **DE10-Lite (MAX10)** FPGA platform.  
It demonstrates essential digital design and FPGA bring-up skills including:

- RTL design of multi-digit BCD arithmetic  
- Seven-segment HEX display driving  
- Quartus design compilation  
- RTL simulation  
- Pin assignment  
- FPGA bring-up and validation  

---

## Features
- Adds two 4-bit BCD digits (0–9)  
- Corrects sums exceeding 9 using +6 correction  
- Cascadable carry-out for multi-digit addition  
- Displays result on DE10-Lite seven-segment HEX display  
- Switch-based input (SW7–4 = A, SW3–0 = B)  
- Carry-out indicator via LEDR0  

---

## 📁 Directory Structure
```
BCD_Adder/
│
├── rtl/            # VHDL/Verilog RTL files
├── sim/            # Simulation testbench + DO files
├── constraints/    # .qsf pin assignments
├── docs/           # Screenshots, diagrams, timing, notes
└── README.md
```

---

## RTL Design Summary

The BCD adder is implemented in three stages:

### 1️⃣ Binary Addition  
A 4-bit full adder computes:  
```
binary_sum = A + B
```

### 2️⃣ BCD Correction Logic  
If the binary sum exceeds 9, correction is applied:  
```
if binary_sum > 9 then 
    corrected_sum = binary_sum + 6
```

### 3️⃣ Carry-Out Generation  
If correction occurs, `carry_out = 1`, otherwise `carry_out = 0`.

This allows chaining multiple BCD adders for multi-digit addition.

---

## 🎛️ Inputs / Outputs

| Signal  | Function                 |
|---------|---------------------------|
| SW7–4   | Operand A (4-bit BCD)     |
| SW3–0   | Operand B (4-bit BCD)     |
| HEX0    | Displays result (0–9)     |
| LEDR0   | Carry-out indicator       |

---

## Simulation (ModelSim)

Run the automated simulation from the `sim/` directory:

```sh
vsim -do run.do
```

### Typical testbench checks:
- All sums from 0+0 through 9+9  
- BCD correction cases (10–18)  
- Carry propagation  
- Correct seven-segment display outputs  

Waveforms may be viewed in ModelSim/QuestaSim.

---

## FPGA Bring-Up Procedure

1. Compile the project in **Quartus Prime**  
2. Apply proper pin assignments using the `.qsf` file  
3. Program the DE10-Lite FPGA (`.sof` file)  
4. Use SW7–4 for operand A  
5. Use SW3–0 for operand B  
6. Observe the result on **HEX0**  
7. Observe carry-out on **LEDR0**  

---

## Skills Demonstrated
- RTL design (VHDL/Verilog)  
- Testbench creation and waveform analysis  
- FPGA synthesis and implementation  
- Quartus Pin Planner usage  
- Timing analysis and correction  
- Seven-segment display decoding  
- Hardware debugging and validation  

---


