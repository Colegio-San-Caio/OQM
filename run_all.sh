#!/usr/bin/env bash
# ========================================================================
# Script   : run_all.sh (Master Framework Orchestrator)
# System   : cURLoeneyeOMQ Hybrid Quantum & Structural FEA Framework
# Purpose  : Compile, test, and execute all core language modules
# ========================================================================

set -e

echo "=== [1/4] Compiling and Testing C Core Module ==="
if [ -f "time_log.c" ]; then
    gcc time_log.c -o time_log_c
    ./time_log_c
fi

echo "=== [2/4] Compiling and Testing Fortran Core Module ==="
if [ -f "time_log.f90" ]; then
    gfortran time_log.f90 -o time_log_f90
    ./time_log_f90
fi

echo "=== [3/4] Compiling and Testing Pascal oeneyecat Utility ==="
if [ -f "oeneyecat.pas" ]; then
    if command -v fpc &> /dev/null; then
        fpc oeneyecat.pas
        ./oeneyecat
    else
        echo "Free Pascal compiler (fpc) not found in current environment. Skipping compilation."
    fi
fi

echo "=== [4/4] Executing System Autoexec Sequence ==="
if [ -f "./autoexec.sh" ]; then
    bash autoexec.sh
fi

echo "=== All Pipeline Verification Steps Completed Successfully ==="
