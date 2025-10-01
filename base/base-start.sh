#!/usr/bin/env bash
set -euo pipefail

# Defaults (envs can be overridden by template)
export JUPYTER_PORT="${JUPYTER_PORT:-8888}"

# Seed the sample notebook if missing
if [ ! -f /workspace/environment_check.ipynb ]; then
  mkdir -p /workspace
  cp -n /opt/sd-webui-hub/notebooks/environment_check.ipynb /workspace/ || true
fi

# Trust the sample notebook to avoid the "Not Trusted" banner
jupyter trust /workspace/environment_check.ipynb >/dev/null 2>&1 || true

# Start JupyterLab (proxy-friendly, no-auth)
# Logs to /workspace/jupyter.log so you can tail it in the pod
exec jupyter lab \
  --ServerApp.root_dir=/workspace \
  --ServerApp.port="${JUPYTER_PORT}" \
  --ServerApp.ip=0.0.0.0 \
  --ServerApp.token='' \
  --ServerApp.password='' \
  --ServerApp.allow_origin='*' \
  --ServerApp.disable_check_xsrf=True \
  --ServerApp.allow_remote_access=True \
  --ServerApp.trust_xheaders=True \
  --no-browser \
  >> /workspace/jupyter.log 2>&1
