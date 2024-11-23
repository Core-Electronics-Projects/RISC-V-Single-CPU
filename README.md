# RISC-V Single Cycle CPU Architecture  

## Overview  
This repository contains the implementation of a **RISC-V Single Cycle CPU** designed for efficiency and simplicity. The architecture adheres to the **RISC-V Instruction Set Architecture (ISA)**, supporting a subset of instructions essential for streamlined computation. With a focus on single-cycle execution, this CPU balances performance with straightforward design principles, making it ideal for educational purposes and lightweight embedded systems.

---

### Key Features  
- **Single-Cycle Design**: Executes one instruction per clock cycle, ensuring predictable timing and simplicity.  
- **Instruction Subset Support**: Implements core RISC-V instructions, including arithmetic, logical, memory, and control operations.  
- **Pipeline-Free**: Eliminates the complexities of pipelining, focusing on a clean and efficient architecture.  
- **Compact and Modular**: Designed for easy understanding, testing, and modification.  

---

### Components  
The architecture is divided into several key components:  

1. **Instruction Fetch Unit (IFU)**  
   - Retrieves the instruction from memory based on the current program counter (PC).  

2. **Decode and Control Unit**  
   - Decodes the instruction to identify opcode, source, and destination registers.  
   - Generates control signals for execution.  

3. **ALU (Arithmetic Logic Unit)**  
   - Performs arithmetic and logical operations.  
   - Supports operations such as addition, subtraction, AND, OR, and shifts.  

4. **Memory Access Unit**  
   - Handles data load and store operations.  

5. **Program Counter (PC)**  
   - Maintains the address of the next instruction.  
   - Updates based on branch and jump conditions.  

6. **Register File**  
   - Contains general-purpose registers used for computation and data storage.  

---

### Supported Instructions  
The CPU currently supports the following instruction categories:  
- **R-Type**: Arithmetic and logical operations (e.g., `ADD`, `SUB`, `AND`, `OR`, `SLL`, `SRL`).  
- **I-Type**: Immediate operations and load instructions (e.g., `ADDI`, `LW`).  
- **S-Type**: Store instructions (e.g., `SW`).  
- **B-Type**: Branch operations (e.g., `BEQ`, `BNE`).  
- **U-Type**: Upper immediate instructions (e.g., `LUI`).  
- **J-Type**: Jump operations (e.g., `JAL`).  

---

### Design Highlights  
- **Simplicity First**: The single-cycle architecture minimizes design complexity, making it an excellent starting point for understanding CPU internals.  
- **Efficient Hardware Resource Utilization**: Optimized for reduced hardware footprint.  
- **Educational Focus**: Provides clear insights into the execution of RISC-V instructions without pipeline hazards.  

---

### Getting Started  


