# ⚡ AI-Powered FPGA Timing Predictor

[![Streamlit App](https://static.streamlit.io/badges/streamlit_badge_black_white.svg)](https://share.streamlit.io/) 
![Python](https://img.shields.io/badge/Python-3.11+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

**Live Demo:** [Click Here to Open App](https://jgikegeiv9xlcycceuxthr.streamlit.app/)

---

## 💡 The Problem
In modern VLSI design, **Static Timing Analysis** is a bottleneck. Chip designers typically wait hours for Synthesis and Place & Route tools just to check if their design meets timing constraints.

## 🛠 The Solution
We built an **AI-Powered EDA Tool** that predicts combinational logic delay in **milliseconds** directly from Verilog RTL code. 

By using a **Physics Informed Machine Learning Engine** this tool identifies architectural bottlenecks without running synthesis, enabling designers to Shift Left and fix timing errors immediately.

---

## ✨ Key Features
* **⏱️ Zero Synthesis Profiling:** Instant delay prediction vs Hours for standard tools.
* **🧠 Explainable AI:** Uses **LIME** to generate visual charts explaining why a circuit is slow.
* **⚛️ Physics Informed Data:** Trained on a synthetic dataset generated from fundamental circuit delay laws overcoming the scarcity of industrial data.
* **💻 Interactive UI:** A Drag and Drop Web Interface built with **Streamlit**.

---

## 📊 Validation & Benchmarks
We validated the tool against industry standard benchmarks and varying circuit complexities:

| Circuit | Logic Depth | Predicted Delay | Status |
| :--- | :--- | :--- | :--- |
| **ISCAS-85 (c17)** | 6 | **1.98 ns** | ✅ Accurate |
| **4-Bit Adder** | 7 | **2.64 ns** | ✅ Accurate |
| **3-Bit Multiplier** | 10 | **3.67 ns** | ✅ Accurate |

As expected, the tool correctly identifies the Multiplier as the slowest component due to its complex adder tree structure.

---

## 📸 Screenshots

### 1. The Web Interface
<img width="1920" height="1080" alt="Screenshot (44)" src="https://github.com/user-attachments/assets/d326fd01-cdbe-48b9-8218-715271544552" />


### 2. LIME Explainability
The model explains that **Logic Depth** is the dominant factor for the Multiplier's delay:
<img width="1388" height="869" alt="1a0c5258d06f3ef5a55acad84b43b6f6122c8d9d5e964ff9d6540239" src="https://github.com/user-attachments/assets/e44ce51b-b5fa-4c73-88d8-cf12a955d222" />


---

## 🚀 How to Run Locally

### Prerequisites
* Python 3.8+
* Pip

### Installation
1.  Clone the repository:
    ```bash
    git clone [https://github.com/](https://github.com/)[YOUR_USERNAME]/fpga-timing-predictor.git
    cd fpga-timing-predictor
    ```

2.  Install dependencies:
    ```bash
    pip install -r requirements.txt
    ```

3.  Run the App:
    ```bash
    streamlit run app.py
    ```

---

## 📂 Project Structure
```text
├── app.py              # The Streamlit Web Application
├── final.ipynb         # Research Notebook
├── rtl_dataset.csv     # Physics-Informed Synthetic Training Data
├── c17.v               # ISCAS-85 Benchmark Circuit
├── multiplier.v        # Test Case: Complex Logic
├── test_circuit.v      # Test Case: Simple Logic
└── requirements.txt    # Project Dependencies
└── data_generator.py   # Physics Informed Data Engine
