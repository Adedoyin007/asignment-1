#!/bin/bash

echo "===== SYSTEM INFORMATION ====="
echo "Hostname: $(hostname)"
echo "Current User: $(whoami)"
echo "Date and Time: $(date)"
echo "Operating System: $(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"')"
echo "Kernel Version: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo
echo "===== CPU INFORMATION ====="
lscpu
echo
echo "===== MEMORY INFORMATION ====="
free -h
echo
echo "Current Working Directory: $(pwd)"

echo "$(date '+%Y-%m-%d %H:%M:%S') - System information collected" >> logs/operations.log
