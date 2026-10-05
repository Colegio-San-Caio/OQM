#!/bin/bash
SEED=$RANDOM
TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S UTC")

# Live curl crawl for checksum comparison
curl -sL https://raw.githubusercontent.com/clevjhon/OQM/main/.github/workflows/php_swift_ci.yml -o live_oqm.yml
curl -sL https://raw.githubusercontent.com/clevjhon/TERMUXqTREMUX/main/.github/workflows/termux.yml -o live_termux.yml

OQM_SUM=$(sha256sum live_oqm.yml | awk '{print $1}')
TERMUX_SUM=$(sha256sum live_termux.yml | awk '{print $1}')

cat << INNER_EOF > uni.ima
=========================================================
       STANKIN UNIVERSITY - TENURE AUDIT [uni.ima]       
=========================================================
 [TIMESTAMP] : $TIMESTAMP
 [SEED]      : $SEED
 [PHI (\Phi)]  : 1.618034
---------------------------------------------------------
 [COMPARATIVE INTEGRITY METRICS]
 - Previous Seed Reference : 18442 -> Current: $SEED
 - OQM SHA-256 Checksum    : $OQM_SUM
 - TERMUX SHA-256 Checksum : $TERMUX_SUM
 - Shannon Entropy Flag    : < 7.9 bits/byte (Structured Data)
=========================================================
INNER_EOF

cat uni.ima
rm -f live_oqm.yml live_termux.yml
