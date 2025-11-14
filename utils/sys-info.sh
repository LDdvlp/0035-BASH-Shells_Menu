#!/usr/bin/env bash
set -euo pipefail

echo "=== System Info ==="
echo "Date       : $(date)"
echo "User       : $(whoami)"
echo "Hostname   : $(hostname)"
echo "Uname      : $(uname -a)"
echo "Shell      : \${SHELL:-unknown}"
echo "PWD        : $PWD"
echo
echo "Disk usage (df -h /):"
df -h /
echo
read -rp "Strike a pause when ready... " _
