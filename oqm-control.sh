#!/usr/bin/env bash
set -e

while true; do
    clear
    echo "=========================================="
    echo "    OQM OPERATOR CONTROL CONSOLE (v1.0)   "
    echo "=========================================="
    echo " 1) Run Automated Deployment (auto-deploy)"
    echo " 2) Check Daemon Status (daemon.iqxd)"
    echo " 3) Start Daemon Service"
    echo " 4) Stop Daemon Service"
    echo " 5) Verify Cryptographic Integrity"
    echo " 6) Launch Core Runtime (dist/D16S)"
    echo " 7) Exit"
    echo "=========================================="
    read -p "Select operator action [1-7]: " choice

    case $choice in
        1)
            echo "(=^ω^=) Executing auto-deploy pipeline..."
            ./auto-deploy.sh
            read -p "Press Enter to continue..."
            ;;
        2)
            echo "(=^‥^=) Checking daemon status..."
            DAEMON_MODE=0 ./daemon.iqxd
            read -p "Press Enter to continue..."
            ;;
        3)
            echo "(=^ ◡ ^=) Starting daemon..."
            DAEMON_MODE=1 ./daemon.iqxd
            read -p "Press Enter to continue..."
            ;;
        4)
            echo "(=ΦωΦ=) Stopping daemon..."
            DAEMON_MODE=2 ./daemon.iqxd
            read -p "Press Enter to continue..."
            ;;
        5)
            echo "(=ΦωΦ=) Verifying checksum manifest..."
            sha256sum -c SHA256SUMS
            read -p "Press Enter to continue..."
            ;;
        6)
            echo "(=^‥^=) Launching D16S runtime..."
            if [ -f "dist/D16S" ]; then
                exec ./dist/D16S
            else
                echo "(=`ω´=) Error: dist/D16S not found. Run deployment first."
                read -p "Press Enter to continue..."
            fi
            ;;
        7)
            echo "(=^‥^=) Exiting OQM control console. Goodbye!"
            exit 0
            ;;
        *)
            echo "(=`ω´=) Invalid selection. Try again."
            sleep 1
            ;;
    esac
done
