#!/usr/bin/env bash
set -e
echo "[oeneye-pkg] Packaging ecosystem components (unsigned build)..."

# Ensure package directories and metadata are set
export DEBEMAIL="ketelhutkai23@gmail.com"
VERSION="v7.2"

# Bundle python module and emulation scripts
tar -czf oeneye-py-ecosystem.tar.gz oeneye/ tex.py

# Generate checksum
sha256sum oeneye-py-ecosystem.tar.gz > oeneye-py-ecosystem.tar.gz.sha256

echo "[oeneye-pkg] Package created successfully: oeneye-py-ecosystem.tar.gz"
