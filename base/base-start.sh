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
if [ -f "${NOTEBOOK_SRC}" ] && [ ! -f "${NOTEBOOK_DST}" ]; then
  cp "${NOTEBOOK_SRC}" "${NOTEBOOK_DST}" || true
  echo "[init] placed ${NOTEBOOK_DST}"
fi

# IMPORTANT: do NOT write any server config that sets LabApp.extension_manager = False
# The UI is already disabled via overrides.json baked in the image.

# launch jupyter (RunPod-friendly; '/' redirects to '/lab')
exec jupyter lab \
  --ip=0.0.0.0 \
  --port="${PORT}" \
  --no-browser \
  --allow-root \
  --IdentityProvider.token="${TOKEN}" \
  --ServerApp.root_dir="${ROOT}" \
  --ServerApp.default_url=/lab \
  --ServerApp.base_url=/ \
  --ServerApp.trust_xheaders=True \
  --ServerApp.allow_remote_access=True \
  --ServerApp.allow_origin="*" \
  --ServerApp.disable_check_xsrf=True
  # If you ever see JL try to create a manager again, you can add:
  # --LabApp.extension_manager=""
