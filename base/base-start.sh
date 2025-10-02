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

# Disable JupyterLab Extension Manager at the server level (no instantiation, no log noise)
mkdir -p ~/.jupyter
cat > ~/.jupyter/jupyter_server_config.py <<'PY'
c = get_config()
c.LabApp.extension_manager = False
c.LabApp.extensions_in_dev_mode = False
PY
echo "[init] Extension Manager disabled via server config"

# launch jupyter
exec jupyter lab \
  --ip=0.0.0.0 \
  --port="${PORT}" \
  --no-browser \
  --allow-root \
  --IdentityProvider.token="${TOKEN}" \
  --ServerApp.root_dir="${ROOT}" \
  --ServerApp.allow_origin="*" \
  --ServerApp.allow_remote_access=True \
  --ServerApp.disable_check_xsrf=True \
  --ServerApp.config_file=/etc/jupyter/jupyter_server_config.py \
  --LabApp.extension_manager=False \
  --LabApp.extensions_in_dev_mode=False
