
# Pipelined MIPS32 Processor in Verilog

This project simulates a 5-stage pipelined MSP32 processor using Verilog HDL.

## Features

- 5-stage pipeline: **IF → ID → EX → MEM → WB**
- Supports instructions: `ADD`, `SUB`, `AND`, `OR`, `MUL`, `SLT`, `ADDI`, `SUBI`, `LW`, `SW`, `BEQZ`, `BNEQZ`, `HLT`
- Basic branching and memory operations
- Two-phase clocking (clk1, clk2)
- Instruction memory and register file simulation


## Tech Stack

- **Verilog HDL** – for hardware description  
- **Xilinx Vivado** – for simulation, synthesis, and waveform analysis  
- **NPTEL Course** – for conceptual learning of pipelining and processor design  

## Acknowledgements

 - NPTEL for providing quality Verilog HDL lectures
- Open-source resources and README templates for formatting guidance

## Usage/Examples


Here's a sample instruction flow:

**Instruction:** `add $t1, $t2, $t3`

**Pipeline Flow:**
- **IF:** Fetch `add` instruction from memory
- **ID:** Decode and read registers `$t2` and `$t3`
- **EX:** Perform addition
- **MEM:** Skip (not a memory operation)
- **WB:** Write result to `$t1`

This shows how data flows through each pipeline stage.



## Lessons Learned

- Gained practical understanding of the 5-stage pipelined MIPS32 architecture.
- Strengthened skills in Verilog HDL for designing and simulating digital circuits.
- Learned to use Xilinx Vivado for project setup, simulation, and waveform analysis.
- Improved knowledge of instruction decoding, hazard handling, and data path design.



