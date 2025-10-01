#!/usr/bin/env bash
set -euo pipefail

JUPYTER_PORT="${JUPYTER_PORT:-8888}"
JUPYTER_TOKEN="${JUPYTER_TOKEN:-}"
JUPYTER_ROOT="${JUPYTER_ROOT:-/workspace}"

mkdir -p "$JUPYTER_ROOT"

# If token is empty → no auth
if [[ -z "$JUPYTER_TOKEN" ]]; then
  TOKEN_FLAG="--ServerApp.token=''"
else
  TOKEN_FLAG="--ServerApp.token=${JUPYTER_TOKEN}"
fi

echo "[base] Starting JupyterLab"
echo "  root:  $JUPYTER_ROOT"
echo "  port:  $JUPYTER_PORT"
echo "  auth:  $([[ -z "$JUPYTER_TOKEN" ]] && echo 'DISABLED' || echo 'token required')"

exec jupyter lab \
  --ServerApp.root_dir="${JUPYTER_ROOT}" \
  --ServerApp.ip=0.0.0.0 \
  --ServerApp.port="${JUPYTER_PORT}" \
  --no-browser \
  --allow-root \
  ${TOKEN_FLAG}
