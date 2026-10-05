#!/usr/bin/env bash
set -e

echo "=== OMQ & ORNOP Master Automation Pipeline ==="
echo "[1] Compiling C Shared Library (OMQ Core)..."
gcc -shared -fPIC -o libomqqiskit.so csrc/omqqiskit.c -lm

echo "[2] Running Python Ctypes FFI Bell State Tests..."
python test_bell.py

echo "[3] Running 3-Qubit Gand Gate Scan Diagnostics..."
python gandOMQscan.py

echo "[4] Building Standalone ORNOP.EXE Executable..."
gcc -O2 csrc/ornop_exec.c -o ORNOP.EXE -lm

echo "[5] Executing ORNOP.EXE Binary..."
./ORNOP.EXE

echo "=== All Systems Verified: SUCCESS ==="

echo "=== Running OMQ Punch-to-Nastran FEA Bridge ==="
python3 omq_punch_nastran_bridge.py
