#!/bin/bash
SEED=$RANDOM
TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S UTC")

echo "=== Executing Live curl Crawl & Checksum Verification ==="
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
 [REMOTE CRAWL & CHECKSUM VERIFICATION]
 OQM Workflow SHA-256:
 $OQM_SUM
 -----------------------------------------------------
 TERMUXqTREMUX Workflow SHA-256:
 $TERMUX_SUM
=========================================================
INNER_EOF

cat uni.ima
rm -f live_oqm.yml live_termux.yml
