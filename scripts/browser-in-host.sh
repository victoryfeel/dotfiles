#!/bin/bash
HOST_IP="192.168.2.101"
PORT=5555
URL="$1"
echo "$URL" | timeout 2 bash -c "cat > /dev/tcp/${HOST_IP}/${PORT}" 2>/dev/null
