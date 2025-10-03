#!/usr/bin/env bash
set -euo pipefail

PORT="${WEBUI_PORT:-7860}"
ROOT="${WEBUI_ROOT:-/workspace}"

echo "[init] Starting Automatic1111 WebUI v1.10.1 on port ${PORT} in ${ROOT}"

cd "${ROOT}/stable-diffusion-webui"

# Recommended flags for RunPod
exec python launch.py \
  --listen \
  --port=${PORT} \
  --enable-insecure-extension-access \
  --disable-console-progressbars \
  --skip-torch-cuda-test \
  --skip-update
