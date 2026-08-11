UART Communication using Verilog HDL

📌 Project Description

UART stands for Universal Asynchronous Receiver Transmitter.

UART is a serial communication protocol used to transfer data between two digital devices. It converts parallel data into serial data during transmission and converts serial data back into parallel data during reception.

This project implements a basic 8-bit UART communication system using Verilog HDL.

🎯 Objectives

- Understand UART communication.
- Design a UART transmitter.
- Design a UART receiver.
- Create a top-level UART module.
- Verify the design using a testbench.
- Generate and observe simulation waveforms.

⚙️ UART Configuration

Parameter| Value
Data bits| 8
Start bit| 1
Stop bit| 1
Parity| None
Data order| LSB first
Communication| Asynchronous

🔹 UART Frame Format

Idle    Start       Data Bits                  Stop
 1        0       D0 D1 D2 D3 D4 D5 D6 D7       1
 ────────┐ ┌──────┬──┬──┬──┬──┬──┬──┬──┐ ┌────
         └─┘      │  │  │  │  │  │  │  │ │

🔹 Block Diagram

                 UART SYSTEM

        ┌─────────────────────┐
        │ UART TRANSMITTER    │
        │                     │
Data ──>│ Parallel to Serial │─── TX
        └─────────────────────┘
                    │
                    │ Serial Data
                    ▼
        ┌─────────────────────┐
        │ UART RECEIVER       │
        │                     │
RX <────│ Serial to Parallel │
        └─────────────────────┘
                    │
                    ▼
                RX_DATA


📂 Project Files

UART-Verilog/
│
├── README.md
├── src/
│   ├── uart_tx.v
│   ├── uart_rx.v
│   └── uart_top.v
│
├── tb/
│   └── uart_tb.v
│
└── simulation/
    └── uart.vcd

"uart_tx.v"

Implements the UART transmitter. It converts 8-bit parallel data into serial data.

"uart_rx.v"

Implements the UART receiver. It converts serial data into 8-bit parallel data.

"uart_top.v"

Connects the transmitter and receiver.

"uart_tb.v"

Provides test inputs and verifies the UART design.

🔄 Working

Transmitter

1. UART remains HIGH when idle.
2. When transmission starts, a LOW start bit is generated.
3. Eight data bits are transmitted from LSB to MSB.
4. A HIGH stop bit is transmitted.
5. Transmission is completed.

Receiver

1. Receiver waits for the LOW start bit.
2. It receives the 8 data bits.
3. The received data is stored in an 8-bit register.
4. "rx_done" becomes HIGH when reception is complete.

🧪 Test Cases

The testbench sends the following values:

55
A5
3C

Expected results:

TX = 55 → RX = 55 → PASS
TX = A5 → RX = A5 → PASS
TX = 3C → RX = 3C → PASS

🛠️ Software Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- GitHub

▶️ Simulation

From the project directory, compile the files:

iverilog -o uart_sim src/uart_tx.v src/uart_rx.v src/uart_top.v tb/uart_tb.v

Run the simulation:

vvp uart_sim

A waveform file named "uart.vcd" will be generated.

Open the waveform using:

gtkwave uart.vcd

📊 Expected Console Output

========================================
       UART SIMULATION STARTED
========================================

TX Data = 55 | RX Data = 55 | PASS
TX Data = A5 | RX Data = A5 | PASS
TX Data = 3C | RX Data = 3C | PASS

========================================
      UART SIMULATION COMPLETED
========================================

📈 Waveform

The following signals can be observed in GTKWave:

clk
rst
tx_start
tx_data
tx
tx_busy
rx_data
rx_done

The "tx" signal contains:

Start → Data Bits → Stop
  0   → D0...D7   →  1

🌐 Applications

UART is commonly used in:

- Microcontrollers
- Embedded systems
- GPS modules
- Bluetooth modules
- Sensors
- Computers
- Serial debugging
- Communication interfaces

✅ Advantages

- Simple design.
- Low hardware complexity.
- Requires fewer wires.
- Easy to implement.
- Widely used in embedded systems.

❌ Limitations

- Requires matching timing/baud-rate settings.
- Generally used for point-to-point communication.
- Slower than some high-speed communication protocols.
- No separate clock signal is transmitted.

🏁 Conclusion

The UART communication system was successfully designed using Verilog HDL.

The transmitter converts parallel data into serial data, and the receiver converts the serial data back into parallel data. The design was tested using a Verilog testbench and verified through simulation.