# ---- Base: CUDA + cuDNN on Ubuntu 22.04 ----
FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1

# System deps: Python, pip, git, tini (nice PID 1), basics
RUN apt-get update && apt-get install -y --no-install-recommends \
      python3 python3-pip python3-venv python3-dev \
      git curl ca-certificates tini \
  && rm -rf /var/lib/apt/lists/*

# Make `python` the default
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
 && python -m pip install --upgrade pip setuptools wheel

# ---- PyTorch (CUDA 12.1 wheels) ----
RUN pip install --index-url https://download.pytorch.org/whl/cu121 \
      torch==2.4.0 torchvision==0.19.0 torchaudio==2.4.0

# --- JupyterLab & tooling ---
RUN pip install --no-cache-dir \
    jupyterlab==4.2.5 \
    notebook==7.2.1 \
    jupyterlab_server==2.27.2 \
    jupyter_server_terminals==0.5.3 \
    jupyterlab-lsp==5.1.0 \
    "python-lsp-server[all]==1.11.0" \
    jupyterlab-git==0.50.1 \
    ipywidgets==8.1.5 \

# Defaults (you can override per-template)
# Leave JUPYTER_TOKEN empty ("") to disable auth; set a value to enable it
ENV JUPYTER_PORT=8888 \
    JUPYTER_TOKEN=""

# Non-root workdir for child images to build upon
WORKDIR /workspace

# You can also set JUPYTER_ROOT via env; default is /workspace
ENV JUPYTER_ROOT=/workspace

# Expose Jupyter for RunPod
EXPOSE 8888

# Add launcher and make it executable
COPY base/base-start.sh /usr/local/bin/base-start.sh
RUN chmod +x /usr/local/bin/base-start.sh

# Copy example notebooks into the image
COPY notebooks /opt/examples

# Disable JupyterLab Extension Manager globally
RUN mkdir -p /usr/local/share/jupyter/lab/settings && \
    printf '%s\n' \
      '{' \
      '  "@jupyterlab/extensionmanager-extension:plugin": {' \
      '    "enabled": false' \
      '  }' \
      '}' \
    > /usr/local/share/jupyter/lab/settings/overrides.json
      
# Keep tini (good signal handling), run our launcher by default
ENTRYPOINT ["/usr/bin/tini","-g","-s","--"]
CMD ["/usr/local/bin/base-start.sh"]
