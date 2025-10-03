# ---- Automatic1111 WebUI image (A1111 + Jupyter under supervisord) ----
FROM ghcr.io/freeradical16/sd-webui-hub:base-v0.1.1

LABEL org.opencontainers.image.source="https://github.com/freeradical16/sd-webui-hub" \
      org.opencontainers.image.description="Automatic1111 Stable Diffusion WebUI v1.10.1 with JupyterLab (supervisord)" \
      org.opencontainers.image.licenses="MIT"

# Keep /workspace for user data (RunPod volume)
WORKDIR /opt

# System deps
RUN apt-get update && apt-get install -y --no-install-recommends \
      git-lfs ffmpeg libgl1 libglib2.0-0 curl \
  && rm -rf /var/lib/apt/lists/* \
  && git lfs install

# Clone A1111 into /opt so it won't be shadowed by /workspace mount
ARG A1111_TAG="v1.10.1"
RUN git clone --depth 1 --branch "${A1111_TAG}" \
      https://github.com/AUTOMATIC1111/stable-diffusion-webui.git \
      /opt/stable-diffusion-webui

# Python deps (Torch already present from base)
RUN pip install --no-cache-dir \
      -r /opt/stable-diffusion-webui/requirements_versions.txt \
   && pip install --no-cache-dir \
      -r /opt/stable-diffusion-webui/requirements.txt

# Optional performance / faster downloads
RUN pip install --no-cache-dir \
      "xformers==0.0.27.post2" \
      hf_transfer

# Faster & quieter HF downloads
ENV HF_HUB_DISABLE_TELEMETRY=1 \
    HF_HUB_ENABLE_HF_TRANSFER=1

# ---- Supervisord to run A1111 + JupyterLab ----
RUN apt-get update && apt-get install -y --no-install-recommends supervisor && \
    rm -rf /var/lib/apt/lists/*

COPY a1111/supervisord.conf /etc/supervisord.conf

# Be explicit about both services' ports
EXPOSE 7860 8888

# Healthcheck (A1111 API; requires --api running)
HEALTHCHECK --interval=30s --timeout=5s --retries=10 CMD \
  curl -fsS "http://127.0.0.1:${WEBUI_PORT:-7860}/sdapi/v1/sd-models" >/dev/null || exit 1

# Launch both via supervisord
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
