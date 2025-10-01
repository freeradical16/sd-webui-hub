#!/usr/bin/env bash
set -euo pipefail

# -------- settings --------
ROOT="${JUPYTER_ROOT:-/workspace}"
PORT="${JUPYTER_PORT:-8888}"
TOKEN="${JUPYTER_TOKEN:-}"

# sample notebook path in the image (matches Dockerfile copy)
NOTEBOOK_SRC="/opt/examples/environment_check.ipynb"
NOTEBOOK_DST="${ROOT}/environment_check.ipynb"

echo "[init] JUPYTER_ROOT=${ROOT}  PORT=${PORT}  TOKEN=${TOKEN:+<set>}"

mkdir -p "${ROOT}"

# copy once if present and not already there
if [ -f "${NOTEBOOK_SRC}" ]; then
  cp -n "${NOTEBOOK_SRC}" "${NOTEBOOK_DST}" || true
  echo "[init] placed ${NOTEBOOK_DST}"
else
  echo "[init] sample notebook not found at ${NOTEBOOK_SRC} (skipping copy)"
fi

# launch jupyter
exec jupyter lab \
  --ip=0.0.0.0 \
  --port="${PORT}" \
  --no-browser \
  --allow-root \
  --ServerApp.root_dir="${ROOT}" \
  --ServerApp.allow_remote_access=True \
  --ServerApp.token="${TOKEN}" \
  --ServerApp.allow_origin="*" \
  --ServerApp.disable_check_xsrf=True \
  --NotebookApp.notebook_dir="${ROOT}"   # harmless shim for older plugins
