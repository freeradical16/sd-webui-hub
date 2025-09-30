# sd-webui-hub: A1111 + JupyterLab + nginx + supervisor
# Base: CUDA 12.1 + cuDNN on Ubuntu 22.04
FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# --- Versions / paths ---
ARG WEBUI_VERSION=v1.10.1
ENV REPO_DIR=/opt/webui \
    VENV_DIR=/opt/venv \
    DATA_DIR=/workspace/a1111-data

# --- System deps (incl. OpenCV runtime), nginx, supervisor ---
RUN apt-get update && apt-get install -y --no-install-recommends \
    git ca-certificates tini bash \
    python3 python3-venv python3-pip \
    libgl1 libglib2.0-0 libsm6 libxext6 libxrender1 \
    nginx supervisor && \
    rm -rf /var/lib/apt/lists/*

# --- Fetch AUTOMATIC1111 (pinned tag or SHA) ---
WORKDIR ${REPO_DIR}
RUN git init && \
    git remote add origin https://github.com/AUTOMATIC1111/stable-diffusion-webui && \
    git fetch --depth 1 origin ${WEBUI_VERSION} && \
    git checkout FETCH_HEAD && \
    git rev-parse --short HEAD && git show -s --format='%h %s'

# --- Python venv + Torch (CUDA 12.1) + xformers + JupyterLab (pinned) ---
RUN python3 -m venv ${VENV_DIR} && \
    ${VENV_DIR}/bin/pip install --upgrade pip setuptools wheel && \
    ${VENV_DIR}/bin/pip install --no-cache-dir --index-url https://download.pytorch.org/whl/cu121 \
      torch==2.4.0 torchvision==0.19.0 torchaudio==2.4.0 && \
    ${VENV_DIR}/bin/pip install --no-cache-dir xformers==0.0.27.post2 && \
    ${VENV_DIR}/bin/pip install --no-cache-dir \
      jupyterlab==4.2.5 \
      notebook==7.2.2 \
      jupyter-server==2.14.2 \
      anyio==4.4.0 \
      exceptiongroup==1.2.2 \
      ipywidgets==8.1.3 \
      nbformat==5.10.4 \
      nbclient==0.10.0 && \
    ${VENV_DIR}/bin/pip cache purge

# --- Copy nginx + supervisor configs ---
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisor/conf.d/services.conf

# --- Expose ports ---
# 3000 = nginx front door, 7860 = A1111 (direct), 8888 = Jupyter (direct)
EXPOSE 3000 7860 8888

# --- Supervisor is PID 1 (runs nginx + A1111 + Jupyter) ---
ENTRYPOINT []
CMD ["/usr/bin/supervisord","-n","-c","/etc/supervisor/conf.d/services.conf"]
