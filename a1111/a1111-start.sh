#!/usr/bin/env bash
set -euo pipefail

PORT="${WEBUI_PORT:-7860}"
EXTRA="${WEBUI_ARGS:-}"

# App lives in image; user data persists under /workspace
SRC_DIR="${WEBUI_SRC:-/opt/stable-diffusion-webui}"
DATA_DIR="${WEBUI_DATA_DIR:-/workspace/a1111}"

echo "[init] A1111 v1.10.1 | src=${SRC_DIR}  data=${DATA_DIR}  port=${PORT}"
mkdir -p "${DATA_DIR}"/{models,outputs,extensions}

cd "${SRC_DIR}"

exec python launch.py \
  --listen \
  --port="${PORT}" \
  --data-dir="${DATA_DIR}" \
  --enable-insecure-extension-access \
  --skip-torch-cuda-test \
  --api \
  ${EXTRA}
