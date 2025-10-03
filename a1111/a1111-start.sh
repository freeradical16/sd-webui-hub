#!/usr/bin/env bash
set -euo pipefail

PORT="${WEBUI_PORT:-7860}"
EXTRA="${WEBUI_ARGS:-}"

# App lives here (not shadowed by RunPod volume)
WEBUI_SRC="/opt/stable-diffusion-webui"

# User data (persistent via RunPod volume at /workspace)
# This keeps models, outputs, configs, extensions installed by the user.
DATA_DIR="${WEBUI_DATA_DIR:-/workspace/a1111}"

echo "[init] A1111 v1.10.1 | src=${WEBUI_SRC}  data=${DATA_DIR}  port=${PORT}"

# Ensure the user data dir exists with common subfolders
mkdir -p "${DATA_DIR}"/{models,outputs,extensions}

cd "${WEBUI_SRC}"

# Launch
exec python launch.py \
  --listen \
  --port="${PORT}" \
  --data-dir="${DATA_DIR}" \
  --enable-insecure-extension-access \
  --skip-torch-cuda-test \
  --skip-update \
  ${EXTRA}
