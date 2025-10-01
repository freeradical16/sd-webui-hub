#!/usr/bin/env bash
set -euo pipefail

# ---- Config (overridable via env / RunPod template) ----
JUPYTER_PORT="${JUPYTER_PORT:-8888}"
JUPYTER_ROOT="${JUPYTER_ROOT:-/workspace}"
JUPYTER_TOKEN="${JUPYTER_TOKEN:-}"

# Ensure workspace exists
mkdir -p "$JUPYTER_ROOT"

# ---- Seed example notebooks/files into /workspace (first boot only) ----
# Copies everything from /opt/examples to /workspace if the target file doesn't exist.
if [ -d /opt/examples ]; then
  shopt -s nullglob
  for src in /opt/examples/*; do
    bn="$(basename "$src")"
    dst="${JUPYTER_ROOT}/${bn}"
    if [ ! -e "$dst" ]; then
      cp -r "$src" "$dst"
      echo "[base] Seeded example: ${bn}"
    fi
  done
  shopt -u nullglob
fi

# ---- Auth handling ----
# Empty token => no auth (public/testing). Non-empty => require token.
if [[ -z "$JUPYTER_TOKEN" ]]; then
  TOKEN_FLAG="--ServerApp.token=''"
  echo "[base] Jupyter auth: DISABLED (no token)"
else
  TOKEN_FLAG="--ServerApp.token=${JUPYTER_TOKEN}"
  echo "[base] Jupyter auth: token required"
fi

echo "[base] Starting JupyterLab"
echo "       root: ${JUPYTER_ROOT}"
echo "       port: ${JUPYTER_PORT}"

exec jupyter lab \
  --ServerApp.root_dir="${JUPYTER_ROOT}" \
  --ServerApp.ip=0.0.0.0 \
  --ServerApp.port="${JUPYTER_PORT}" \
  --ServerApp.allow_remote_access=True \
  --ServerApp.disable_check_xsrf=True \
  --no-browser \
  --allow-root \
  ${TOKEN_FLAG}
