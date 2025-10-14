# ---- Base: CUDA + cuDNN on Ubuntu 22.04 ----
FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1

# OCI labels (helps GHCR discoverability)
LABEL org.opencontainers.image.source="https://github.com/freeradical16/sd-webui-hub" \
      org.opencontainers.image.description="CUDA 12.1 + PyTorch + JupyterLab base for SD WebUI stacks (RunPod-ready)" \
      org.opencontainers.image.licenses="MIT"

# System deps: Python, pip, git, tini (PID 1), basics
RUN apt-get update && apt-get install -y --no-install-recommends \
      python3 python3-pip python3-venv python3-dev \
      git curl ca-certificates tini \
  && rm -rf /var/lib/apt/lists/*

# Make `python` the default and update pip toolchain
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
 && python -m pip install --upgrade pip setuptools wheel

# ---- PyTorch (CUDA 12.1 wheels) ----
RUN pip install --index-url https://download.pytorch.org/whl/cu121 \
      torch==2.4.0 torchvision==0.19.0 torchaudio==2.4.0

# --- JupyterLab & tooling (JL 4.x compatible set; no widgets/monitor) ---
RUN pip install --no-cache-dir \
    jupyterlab==4.2.5 \
    notebook==7.2.1 \
    jupyterlab_server==2.27.2 \
    jupyter_server_terminals==0.5.3 \
    jupyterlab-lsp==5.1.0 \
    "python-lsp-server[all]==1.11.0"

# Defaults (overridable via template)
ENV JUPYTER_PORT=8888 \
    JUPYTER_ROOT=/workspace \
    JUPYTER_TOKEN=""

# Non-root working directory (mounted in RunPod)
WORKDIR /workspace

# Expose Jupyter for RunPod proxy
EXPOSE 8888

# Copy launcher + make it executable
COPY base/base-start.sh /usr/local/bin/base-start.sh
RUN chmod +x /usr/local/bin/base-start.sh

# Copy ONLY the environment check notebook
COPY notebooks/environment_check.ipynb /opt/examples/environment_check.ipynb

# Disable JupyterLab Extension Manager UI (quiet + reproducible)
RUN mkdir -p /usr/local/share/jupyter/lab/settings && \
    printf '%s\n' \
      '{' \
      '  "@jupyterlab/extensionmanager-extension:plugin": {' \
      '    "enabled": false' \
      '  }' \
      '}' \
    > /usr/local/share/jupyter/lab/settings/overrides.json

# (Optional) Healthcheck so orchestrators auto-restart if Jupyter dies
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD curl -fsS http://127.0.0.1:8888/lab || exit 1

# Keep tini (PID 1), then run our launcher
ENTRYPOINT ["/usr/bin/tini","-g","-s","--"]
CMD ["/usr/local/bin/base-start.sh"]
