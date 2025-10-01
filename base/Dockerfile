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

# ---- JupyterLab (pinned to avoid anyio/exceptiongroup breakages) ----
# These versions play nicely on Python 3.10 in containers.
RUN pip install \
      jupyterlab==4.2.5 \
      notebook==7.1.3 \
      jupyter-server==2.13.0 \
      anyio==4.4.0 \
      exceptiongroup==1.2.1 \
      jupyterlab_server==2.27.2 \
      jupyter_server_terminals==0.5.3 \
      jupyter-lsp==2.2.5

# Defaults (you can override per-template)
# Leave JUPYTER_TOKEN empty ("") to disable auth; set a value to enable it
ENV JUPYTER_PORT=8888 \
    JUPYTER_TOKEN=""

# Non-root workdir for child images to build upon
WORKDIR /workspace

# Tini as entrypoint (plays nice with signals); child images can override CMD
ENTRYPOINT ["/usr/bin/tini", "--"]

# Example default command just starts a shell.
# Child images (A1111/Forge) will supply their own start script / CMD.
CMD ["/bin/bash"]
