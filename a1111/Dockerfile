# ---- Automatic1111 WebUI image (built on our base) ----
FROM ghcr.io/freeradical16/sd-webui-hub:base-v0.1.1

LABEL org.opencontainers.image.source="https://github.com/freeradical16/sd-webui-hub" \
      org.opencontainers.image.description="Automatic1111 Stable Diffusion WebUI v1.10.1 on top of sd-webui-hub base" \
      org.opencontainers.image.licenses="MIT"

# Keep /workspace exclusively for user data (RunPod volume)
WORKDIR /opt

# System deps for WebUI
RUN apt-get update && apt-get install -y --no-install-recommends \
      git-lfs ffmpeg libgl1 libglib2.0-0 curl \
  && rm -rf /var/lib/apt/lists/* \
  && git lfs install

# Clone A1111 into /opt so it's NOT shadowed by the /workspace volume
ARG A1111_TAG="v1.10.1"
RUN git clone --depth 1 --branch ${A1111_TAG} \
      https://github.com/AUTOMATIC1111/stable-diffusion-webui.git \
      /opt/stable-diffusion-webui

# Pre-install python deps (Torch already present in base image)
RUN pip install --no-cache-dir \
      -r /opt/stable-diffusion-webui/requirements_versions.txt \
   && pip install --no-cache-dir \
      -r /opt/stable-diffusion-webui/requirements.txt

# Optional extras:
# - xformers: VRAM/memory optimizations (matching CUDA 12.1 from base)
# - hf_transfer: enables Hugging Face fast download backend
RUN pip install --no-cache-dir \
      "xformers==0.0.27.post2" \
      hf_transfer

# Faster & quieter Hugging Face downloads
ENV HF_HUB_DISABLE_TELEMETRY=1 \
    HF_HUB_ENABLE_HF_TRANSFER=1

# Start script
COPY a1111/a1111-start.sh /usr/local/bin/a1111-start.sh
RUN chmod +x /usr/local/bin/a1111-start.sh

# Defaults (can be changed in RunPod template)
ENV WEBUI_PORT=7860 \
    WEBUI_ARGS=""

EXPOSE 7860

# Optional healthcheck (works best if API is enabled via WEBUI_ARGS="--api")
HEALTHCHECK --interval=30s --timeout=5s --retries=10 CMD \
  curl -fsS "http://127.0.0.1:${WEBUI_PORT:-7860}/sdapi/v1/sd-models" >/dev/null || exit 1

# Base image already uses tini as ENTRYPOINT; just set CMD
CMD ["/usr/local/bin/a1111-start.sh"]
