# 📘 Week 3 Progress Report

**Project:** Sparse Systolic Array for AI Acceleration and Matrix Computation
**Team:** Circuit Crafters
**Program:** IIIT-B Chip Design Studio

---

## 🔹 Objective

* Enhance the dense systolic array with **sparsity-aware execution**
* Reduce redundant MAC operations caused by zero-valued operands
* Validate functional correctness under sparse input conditions

---

## 🔹 Work Done

### 1. Sparsity-Aware Control Logic

* Implemented **zero-detection logic** for input operands
* Generated **per-PE enable signals** based on operand values
* Disabled MAC operations when one or both operands are zero

### 2. Sparse 2×2 Systolic Array

* Retained the same MAC-based PE datapath as the dense baseline
* Integrated sparsity control without modifying the core MAC unit
* Enabled selective computation while preserving correct outputs

### 3. Verification

* Created a sparse-input testbench
* Introduced intentional zero values in matrix operands
* Verified that:

  * Output values match dense computation results
  * Accumulation does not occur during zero-operand cycles

---

## 🔹 Code Implemented

| File Name                  | Description                                       |
| -------------------------- | ------------------------------------------------- |
| `pe_mac.v`                 | MAC-based Processing Element (unchanged datapath) |
| `zero_detect.v`            | Zero-detection logic for sparsity control         |
| `systolic_2x2_sparse.v`    | Sparsity-aware 2×2 systolic array                 |
| `systolic_2x2_sparse_tb.v` | Testbench with sparse matrix inputs               |

📂 All RTL and testbench files are available in the `code/` directory.

---

## 🔹 Simulation Summary

* Tool: **Vivado XSIM**
* Sparse matrices applied as inputs
* Observed behavior:

  * Correct final matrix outputs
  * No accumulation during zero-operand cycles
* Confirms correct sparsity-aware execution

---

## 🔹 Analysis

### Key Findings

* Dense baseline: **8 MAC operations**
* Sparse execution: **5 MAC operations**
* **37.5% reduction** in MAC activity for the same computation

### Insights

* Internal enable gating is a reliable indicator of computational efficiency
* MAC operation count serves as a proxy for dynamic power reduction
* Control-level optimizations can significantly improve efficiency without altering datapath

---

## 🔹 Challenges Faced

* Limited direct power estimation support in Vivado for small designs
* Difficulty in absolute power comparison for a 2×2 array
* Required careful validation to separate correctness from efficiency

---

## 🔹 Outcome

* Successfully demonstrated a **functionally correct sparsity-aware systolic array**
* Reduced redundant computation while maintaining identical outputs

---

## 🔹 Next Steps

* Scale the design to larger systolic arrays
* Explore structured sparsity patterns
* Integrate ASIC-oriented power analysis flows

---
