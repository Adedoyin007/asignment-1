#!/bin/bash

# Network diagnostic tool
# Usage: ./network-check.sh <hostname-or-ip> [port]
# Checks DNS resolution, ICMP connectivity, network interfaces,
# and optional TCP port connectivity.

HOST="$1"
PORT="$2"

if [ -z "$HOST" ]; then
    echo "Usage: ./network-check.sh <hostname-or-ip> [port]"
    exit 2
fi

RESOLVED_ADDRESS=$(getent ahostsv4 "$HOST" | awk 'NR==1 {print $1}')

if [ -z "$RESOLVED_ADDRESS" ]; then
    echo "Error: Unable to resolve host: $HOST"
    exit 1
fi

echo "Host: $HOST"
echo "Resolved Address: $RESOLVED_ADDRESS"

echo
echo "Checking connectivity..."

if ping -c 1 -W 3 "$HOST" > /dev/null 2>&1; then
    echo "Connectivity: SUCCESS"
else
    echo "Connectivity: FAILED"
fi

echo
echo "===== NETWORK INTERFACES ====="
ip addr

if [ -n "$PORT" ]; then

    if ! [[ "$PORT" =~ ^[0-9]+$ ]]; then
        echo "Error: Port must be a number."
        exit 2
    fi

    if (( PORT < 1 || PORT > 65535 )); then
        echo "Error: Port must be between 1 and 65535."
        exit 2
    fi

    echo
    echo "Checking TCP connectivity to $HOST on port $PORT..."

    if timeout 5 bash -c "</dev/tcp/$HOST/$PORT" 2>/dev/null; then
        echo "TCP connection: SUCCESS"
    else
        echo "TCP connection: FAILED"
    fi
fi
echo "$(date '+%Y-%m-%d %H:%M:%S') - Network check performed for $HOST." >> logs/operations.log

exit 0

