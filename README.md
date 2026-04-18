# 8-Bit Arithmetic Logic Unit (ALU) in Verilog

This repository contains the Verilog RTL design and simulation testbench for a parameterized 8-bit Arithmetic Logic Unit (ALU). The ALU performs basic arithmetic and bitwise logical operations, outputting an 8-bit result alongside `Zero` and `Carry/Borrow` status flags.

## Features
* **8-bit Data Path:** Accepts two 8-bit operands (`A` and `B`).
* **3-bit Operation Code:** Supports 8 distinct operations selected via the `alu_op` input.
* **Status Flags:** * `Zero`: Goes HIGH (`1`) when the 8-bit result is strictly `0x00`.
  * `Carry`: Captures arithmetic overflow, subtract borrows, and shifted-out bits.

## Supported Operations

| `alu_op` (Binary) | Operation | Description |
| :---: | :--- | :--- |
| `000` | **ADD** | Adds `A` and `B`. Sets `carry` if overflow occurs. |
| `001` | **SUB** | Subtracts `B` from `A`. `carry` acts as a borrow flag. |
| `010` | **AND** | Bitwise logical AND of `A` and `B`. |
| `011` | **OR** | Bitwise logical OR of `A` and `B`. |
| `100` | **XOR** | Bitwise logical XOR of `A` and `B`. |
| `101` | **NOT** | Bitwise logical NOT of `A` (ignores `B`). |
| `110` | **SLL** | Shift `A` Left Logical by 1 bit. MSB becomes `carry`. |
| `111` | **SRL** | Shift `A` Right Logical by 1 bit. LSB becomes `carry`. |

## Module Interface

```verilog
module alu_8bit (
    input  wire [7:0] a,       // 8-bit operand A
    input  wire [7:0] b,       // 8-bit operand B
    input  wire [2:0] alu_op,  // 3-bit operation selector
    output reg  [7:0] result,  // 8-bit result
    output wire       zero,    // Zero flag
    output reg        carry    // Carry/Borrow flag
);
