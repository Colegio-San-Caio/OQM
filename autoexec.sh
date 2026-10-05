#!/usr/bin/env bash
# ========================================================================
# Script   : autoexec.sh (OMQbiosReader Startup Hook)
# System   : cURLoeneyeOMQ Hybrid Quantum & Structural FEA Framework
# Purpose  : Automatically initialize and execute system utilities on boot
# ========================================================================

echo "=== Executing OMQbiosReader Autoexec Routine ==="

# Check and execute oeneyecat utility if compiled
if [ -f "./oeneyecat" ]; then
    ./oeneyecat
elif [ -f "./oeneyecat.pas" ]; then
    echo "Compiling oeneyecat.pas..."
    # If a Pascal compiler is available or fallback simulation runs
    fpc oeneyecat.pas && ./oeneyecat
else
    echo "Warning: oeneyecat binary or source not found."
fi

echo "=== Autoexec Sequence Complete ==="
