#!/usr/bin/env bash

pkill -f "hypr-api.py" >/dev/null 2>&1


source /home/lobiplayer/.scripts/hypr-api/venv/bin/activate

HOST_IP="${HOST_IP:-$(ip route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<=NF;i++) if($i=="src") {print $(i+1); exit}}')}"
HOST_IP="${HOST_IP:-$(hostname -I 2>/dev/null | awk '{print $1}')}"
HOST_IP="${HOST_IP:-127.0.0.1}"

exec uvicorn /home/lobiplayer/.scripts/hypr-api/hypr-api:app \
  --host "$HOST_IP" \
  --port 8129 \
  --log-level warning
