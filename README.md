# 🔐 FSM-Based Digital Lock (Verilog)

## 📖 Overview
This project implements a **digital lock system** using a **Finite State Machine (FSM)** and **datapath architecture** in Verilog.

The system unlocks when the correct input sequence **1011** is entered.

---

## 🧠 Design Architecture

The design is divided into:

### 🔹 Datapath
- 4-bit shift register
- Captures serial input sequence

### 🔹 Controller (FSM)
- Controls shifting and checking
- Detects correct sequence
- Generates unlock signal

---

## ⚙️ Working

1. Input bits are shifted into a 4-bit register
2. After 4 clock cycles:
   - FSM checks the sequence
3. If sequence = `1011`:
   - `unlock = 1` for one clock cycle
4. System resets for next attempt

---

## 🧪 Simulation

Simulated using **Xilinx Vivado**

### ✅ Test Cases:
- Correct sequence → Unlock triggered
- Incorrect sequence → No unlock
- Multiple attempts supported

---

## 📊 Waveform

![Waveform](waveform.png)

---

## 📁 Files

| File | Description |
|------|------------|
| `datapath.v` | Shift register |
| `controller.v` | FSM logic |
| `digital_lock_top.v` | Top module |
| `tb.v` | Testbench |

---

## 🚀 How to Run

1. Open Vivado
2. Add all `.v` files
3. Set testbench as top module
4. Run simulation
5. Observe waveform

---

## 🏁 Result

✔ Correct sequence detection  
✔ Synchronous design  
✔ Clean FSM + datapath separation  

---

## 👨‍💻 Author
Your Name
