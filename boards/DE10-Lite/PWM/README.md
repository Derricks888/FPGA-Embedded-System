# 📘 PWM LED Brightness Controller
### DE10-Lite FPGA Implementation

This project implements a **Pulse Width Modulation (PWM) LED brightness controller** on the Intel **DE10-Lite (MAX10)** FPGA platform.  
It demonstrates essential digital design and FPGA bring-up skills including:

- RTL design of a hardware PWM generator  
- Duty-cycle control using slide switches  
- LED brightness modulation  
- Quartus design compilation  
- Optional RTL simulation  
- Pin assignment  
- FPGA bring-up and hardware validation  

---

## 🔧 Features
- 8-bit duty-cycle control (0–255)  
- Visible LED brightness variation on LEDR0  
- Debounced mechanical switch inputs  
- PLL-based clock generation  
- Clean hierarchical RTL (PWM core, debouncer, top-level)  
- Fully synthesizable on the MAX10 FPGA  

---

## 📁 Directory Structure
```
PWM/
│
├── rtl/               # Verilog RTL files (PWM core, top-level, PLL, debouncer)
├── sim/               # Optional testbench + ModelSim DO files
├── constraints/       # .qsf pin assignments + .sdc timing constraints
├── docs/              # Screenshots, diagrams, timing, notes
└── README.md
```

---

## 🧠 RTL Design Summary

The PWM controller is implemented in three stages:

### 1️⃣ Free-Running Counter  
A counter increments at the system clock frequency:
```
counter = counter + 1
```

### 2️⃣ Duty-Cycle Comparator  
The PWM output is high when:
```
counter < duty_cycle
```

This generates a variable duty-cycle signal that controls LED brightness.

### 3️⃣ Debounced Switch Inputs  
A debouncer filters mechanical switch bounce to prevent duty-cycle glitches.

---

## 🎛️ Inputs / Outputs

| Signal         | Function                                                |
|----------------|----------------------------------------------------------|
| SW7–0          | 8-bit duty-cycle value (0 = off, 255 = max brightness)  |
| LEDR0          | PWM output to LED                                       |
| MAX10_CLK1_50  | 50 MHz system clock                                     |

---

## 🧪 Simulation (ModelSim)

If a testbench is included in the `sim/` directory, run:

```sh
vsim -do run.do
```

### Typical testbench checks:
- 0% duty-cycle  
- 25% duty-cycle  
- 50% duty-cycle  
- 75% duty-cycle  
- 100% duty-cycle  
- PWM waveform correctness  
- Counter rollover behavior  

Waveforms may be viewed in ModelSim/QuestaSim.

---

## 🔬 FPGA Bring-Up Procedure

1. Compile the project in **Quartus Prime Lite**  
2. Apply correct pin assignments using the `.qsf` file  
3. Program the DE10-Lite FPGA (`.sof` file)  
4. Use SW7–0 to set the duty-cycle value  
5. Observe LED brightness on **LEDR0**  
   - `0x00` → LED off  
   - `0x80` → approximately 50% brightness  
   - `0xFF` → LED fully on  

---

## 🧩 Skills Demonstrated
- RTL design in Verilog  
- PWM generation and timing analysis  
- Clock-domain management using PLLs  
- Debouncing logic for mechanical switches  
- FPGA synthesis and implementation  
- Quartus Pin Planner usage  
- FPGA hardware debugging and validation  

---

Place screenshots, timing reports, oscilloscope/Saleae captures, and block diagrams in the `docs/` folder.
