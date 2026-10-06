#!/usr/bin/env bash
set -e
[ -f "./css.iqxd" ] && source ./css.iqxd

echo -e "${OQM_PRIMARY}(=^ ◡ ^=) Executing User1 Automated Pipeline...${OQM_RESET}"

if [ -f "./main.iqxd" ]; then
    cat ./main.iqxd
elif [ -f "./main.c" ]; then
    cat ./main.c
else
    echo -e "${OQM_WARN}(=`ω´=) No main target found for User1 cat routine.${OQM_RESET}"
    exit 1
fi
