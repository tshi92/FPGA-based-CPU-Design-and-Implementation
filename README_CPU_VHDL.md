# 🧠 CPU Design and Implementation (VHDL, FPGA)

This project implements a simple **CPU architecture** on an FPGA platform using **VHDL**.  
It covers instruction design, timing cycles, module structure, and verification through simulation and hardware testing.  

---

## 📚 Overview

**Goal:**  
To design and implement a basic CPU that supports arithmetic, logic, and control instructions, with all core components written in VHDL and synthesized using **Xilinx ISE**.

**Environment:**
- **Xilinx ISE 9.1i** — synthesis and implementation  
- **ModelSim XE II v5.6a** — functional simulation  
- **SD2100 Digital Logic Design Platform** — hardware debugging and verification

---

## 🎯 Objectives

- Master the **Xilinx ISE** and **ModelSim** toolchains  
- Learn and apply **VHDL programming**  
- Design a complete **CPU datapath and control unit**  
- Understand the **processor architecture** and instruction execution flow  
- Implement and test the design on an **FPGA board**

---

## ⚙️ CPU Architecture

### Core Modules

| Module | Description |
|--------|--------------|
| **Clock (`count.vhd`)** | Generates 4-phase timing signals (`T0–T3`) controlling all modules |
| **Fetch (`fetch.vhd`)** | Handles instruction fetching and PC updates |
| **ALU (`alu.vhd`)** | Executes arithmetic, logic, and address computations |
| **Store (`store.vhd`)** | Temporarily stores ALU or memory data |
| **Writeback (`writeback.vhd`)** | Writes computation results and PC values back to registers |
| **Memory Control (`memctrl.vhd`)** | Manages data transfer between CPU and RAM |
| **Top-Level (`cpu.vhd`)** | Integrates all modules and external interfaces |

---

## 🧩 Instruction Design

### Instruction Format

Multiple formats are supported to handle:
- Immediate values
- Register-to-register operations
- Direct and indirect memory addressing
- Jump and conditional control instructions

| Example Format | Description |
|----------------|--------------|
| `op (5 bits) + reg (3 bits) + imm (8 bits)` | Register with immediate value |
| `op (5 bits) + reg1 (3 bits) + reg2 (3 bits)` | Register-to-register operations |
| `op (5 bits) + memory address (8 bits)` | Direct memory access |

### Example Opcodes

| Opcode | Instruction | Description |
|--------|--------------|-------------|
| `00000` | `mov reg, *` | Move immediate to register |
| `00001` | `mov reg, [*]` | Load from memory |
| `00010` | `mov [*], reg` | Store to memory |
| `00100` | `adc reg, *` | Add with carry |
| `01000` | `and reg, *` | Bitwise AND |
| `01110` | `jmp *` | Unconditional jump |
| `10000` | `jz *` | Jump if zero |
| `10001` | `mov reg, [reg]` | Indirect load |

---

## ⏱️ Timing Cycles

| Cycle | Operation |
|-------|------------|
| **T0** | Instruction fetch |
| **T1** | ALU / address / memory access |
| **T2** | Storage control |
| **T3** | Register or PC writeback |

---

## 🔧 Simulation and Verification

Simulation is performed for all modules using **ModelSim**:

- **Clock module:** Verifies correct 4-phase generation  
- **Fetch module:** Tests instruction loading and PC update  
- **ALU module:** Confirms arithmetic, logic, and jump operations  
- **Writeback module:** Validates correct register and PC updates  
- **Memory control:** Confirms correct signal behavior for read/write cycles  

---

## 🧠 Example Instruction Sequence

| Instruction | Machine Code | Description |
|--------------|--------------|--------------|
| `mov reg7, 0` | `0700h` | Load 0 into R7 |
| `mov [50], reg7` | `1750h` | Store R7 into address 0x50 |
| `mov reg2, [50]` | `0A50h` | Load from address 0x50 into R2 |
| `adc reg5, 8` | `2508h` | Add 8 to R5 |
| `jmp 0030h` | `7030h` | Jump to address 0x30 |
| `jz 0030h` | `8030h` | Jump to 0x30 if zero flag is set |

---

## 🧮 UCF (Pin Constraints)

The `cpu.ucf` file defines FPGA pin mapping for all I/O signals such as:
- Address bus (`abus<0–15>`)
- Data bus (`dbus<0–15>`)
- Control lines (`nrd`, `nwr`, `nmerq`, `nbhe`, `nble`)
- Debug LEDs (`tout`, `irout`, `reout`, etc.)

---

## 🧰 Troubleshooting & Lessons Learned

Common issues encountered during FPGA testing:
1. **PC value updates twice per cycle** — fixed by moving `PC + 1` logic into the writeback stage  
2. **Carry flag not updated correctly** — separated arithmetic and flag update into different clock phases  
3. **One-cycle delay in ALU output** — resolved by expanding process sensitivity lists  
4. **Register writeback timing issue** — corrected by generating write address directly from IR within ALU  

Through iterative debugging, a deeper understanding of **CPU datapath design**, **timing synchronization**, and **VHDL hardware description** was achieved.

---

## 🧑‍💻 Author

**Tuo Shi (石拓)**  
Class: 1103105  
Student ID: 1110310504  

---

## 🧾 License

This project is intended for **educational and research purposes**.  
Feel free to reuse and adapt with proper attribution.
