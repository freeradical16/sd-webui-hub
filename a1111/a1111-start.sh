#!/usr/bin/env bash
set -euo pipefail

PORT="${WEBUI_PORT:-7860}"
# where you cloned A1111 (match your Dockerfile)
SRC_DIR="${WEBUI_SRC:-/opt/stable-diffusion-webui}"
# where user data (models, outputs, extensions) should live
DATA_DIR="${WEBUI_DATA:-/workspace/a1111}"
EXTRA="${WEBUI_ARGS:-}"

echo "[init] A1111 v1.10.1 | src=${SRC_DIR}  data=${DATA_DIR}  port=${PORT}"

cd "${SRC_DIR}"

exec python launch.py \
  --listen \
  --port="${PORT}" \
  --data-dir="${DATA_DIR}" \
  --enable-insecure-extension-access \
  --skip-torch-cuda-test \
  --api \
  ${EXTRA}
