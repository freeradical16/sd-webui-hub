#!/usr/bin/env bash
set -euo pipefail

# Configurable via RunPod template env vars
PORT="${WEBUI_PORT:-7860}"
ROOT="${WEBUI_ROOT:-/workspace}"
EXTRA="${WEBUI_ARGS:-}"

APP_DIR="${ROOT}/stable-diffusion-webui"

echo "[init] A1111 v1.10.1 | root=${ROOT} port=${PORT}"
mkdir -p "${ROOT}/models" "${ROOT}/outputs" "${ROOT}/extensions" || true

# Fail fast with a clear message if the repo isn't present
if [[ ! -d "${APP_DIR}" ]]; then
  echo "[init][ERROR] ${APP_DIR} not found."
  echo "Contents of ${ROOT}:"
  ls -la "${ROOT}" || true
  exit 1
fi

cd "${APP_DIR}"

# Launch
exec python launch.py \
  --listen \
  --port "${PORT}" \
  --enable-insecure-extension-access \
  --disable-console-progressbars \
  --skip-torch-cuda-test \
  --skip-update \
  # --api \            # uncomment if you want the REST API / healthchecks
  ${EXTRA}
