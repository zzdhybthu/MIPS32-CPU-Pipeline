# Pipeline-CPU

## Description

MIPS Pipeline CPU implemented in Verilog HDL.

Driven by the course "Fundamental Experiment of Digital Logic and Processor" in the 2rd semester of the undergraduate program in the School of Electronic and Engineering, Tsinghua University.

## Directory Structure

```bash
.
|-- LICENSE
|-- README.md
|-- docs/
|-- project/
|-- reference
|   |-- MIPS32_pipeline/
|   |-- MIPS_Pipeline/
|   `-- PipelineCPU/
|-- report
|   |-- asserts/
|   |-- report.pdf
|   `-- report.tex
|-- src
|   |-- config
|   |   `-- CPU.xdc
|   |-- source
|   |   |-- ALU.v
|   |   |-- ALU_Ctrl.v
|   |   |-- Branch.v
|   |   |-- CPU.v
|   |   |-- Ctrl.v
|   |   |-- Data_Mem.v
|   |   |-- EX_MEM.v
|   |   |-- Forward.v
|   |   |-- ID_EX.v
|   |   |-- IF_ID.v
|   |   |-- Inst_Mem.v
|   |   |-- MEM_WB.v
|   |   |-- PC.v
|   |   |-- RF.v
|   |   `-- UART
|   |       |-- UART_RX.v
|   |       `-- UART_TX.v
|   `-- test
|       |-- Test_CPU.v
|       `-- asm
|           |-- binary_insert_sort.asm
|           |-- binary_insert_sort_uart.asm
|           |-- data.bin
|           `-- script
|               |-- bin_reader.cpp
|               |-- binary_insert_sort_runnable.asm
|               |-- data_generator.py
|               |-- inst_generator.py
|               `-- load_file_runnable.asm
`-- tools
    |-- Mars4_5.jar
    `-- serial_port_utility_latest.exe
```

## Usage

### Prerequisites

- Vivado 2017.4
- Serial Port Utility
- Mars.jar
- Target device: xc7a35tfgg484-1

#### Data Generation

- Run

  ```bash
  g++ src/test/asm/script/bin_reader.cpp -o src/test/asm/script/bin_reader
  chmod +x src/test/asm/script/bin_reader
  ./src/test/asm/script/bin_reader src/test/asm/data.bin
  ```
- Paste output into `src/test/asm/data.txt`.

- Then run

  ```bash
  python src/test/asm/script/data_generator.py
  ```
#### Instruction Generation

- Compile `src/test/asm/binary_insert_sort.asm` and `src/test/asm/binary_insert_sort_uart.asm` in Mars.

- Dump Hexadecimal in `src/test/asm/binary_insert_sort.hex` and `src/test/asm/binary_insert_sort_uart.hex`.

- Then run

  ```bash
  python src/test/asm/script/inst_generator.py
  ```
### Test CPU

- Paste content of `binary_insert_sort.inst` into `Inst_Mem.v`.
- Paste content of `data.inst` into `Data_Mem.v`.
- Top `Test_CPU.v` for simulation or top `CPU.v` for synthesis and implementation in Vivado.

### Test UART

- Paste content of `binary_insert_sort_uart.inst` into the `Inst_Mem.v`.
- Delete the content of `data.inst` in the `Data_Mem.v`.
- Top `CPU.v` for synthesis and implementation in Vivado.
- Pragram device.
- Open Serial Port Utility and set the baud rate to 9600.
- Send hex serial in `data.hex` to the FPGA board.

## License

[MIT](LICENSE)