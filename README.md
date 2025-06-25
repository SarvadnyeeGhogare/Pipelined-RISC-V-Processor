Pipelined Processor

This project implements a 5-stage pipelined RISC-V processor supporting the RV32I instruction set architecture,designed using Verilog HDL.
The processor features well-defined pipeline stages—Fetch, Decode, Execute, Memory, and Writeback,along with hazard detection and forwarding logic to maintain instruction throughput.
It simulates realistic instruction flow and memory operations, including handling stalls, flushes, and control hazards for branching and data dependencies.

5-Stage Pipelined Architecture
Implements standard instruction execution pipeline:

IF (Instruction Fetch)

ID (Instruction Decode & Register Fetch)

EX (Execute)

MEM (Memory Access)

WB (Write Back)

Executes all base 32-bit integer instructions of the RISC-V architecture.
Includes ALU operations (add, sub, and, or, sll, srl...), branches (beq, bne...), jumps (jal, jalr), and memory access (lw, sw).

Performs operations like addition, subtraction, AND, OR, XOR, shifts, and set-less-than comparisons.
Driven by ALUControl signals based on decoded instructions.

Dual read ports and one write port allow simultaneous access to two source registers and writing results to the destination register.
Register x0 is hardwired to zero as per RISC-V specs.

Hazard Detection Unit-
Detects load-use hazards (e.g., when an instruction depends on a load result in the next cycle).
Stalls the pipeline by disabling PC update and instruction decode temporarily to maintain correctness.

 Data Forwarding Unit-
Implements data forwarding from EX/MEM and MEM/WB stages to resolve read-after-write (RAW) data hazards.
Minimizes stalling by bypassing the ALU inputs when possible.

 Pipeline Stalling and Flushing Mechanism-
Inserts NOPs (bubbles) to handle data hazards when forwarding is not sufficient.
Flushes instructions when branch decisions are made to discard incorrect paths.


