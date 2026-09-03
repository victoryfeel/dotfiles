#!/bin/bash
HOST_IP="192.168.2.101"
PORT=5555
URL="$1"

if [[ -z "$URL" ]]; then
  echo "Usage: $0 <url>" >&2
  exit 1
fi
echo "$URL" | timeout 2 bash -c "cat > /dev/tcp/${HOST_IP}/${PORT}" 2>/dev/null
