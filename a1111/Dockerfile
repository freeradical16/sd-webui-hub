# ---- Automatic1111 WebUI build ----
FROM ghcr.io/freeradical16/sd-webui-hub:base-v0.1.1

LABEL org.opencontainers.image.source="https://github.com/freeradical16/sd-webui-hub" \
      org.opencontainers.image.description="Automatic1111 Stable Diffusion WebUI v1.10.1 on top of sd-webui-hub base" \
      org.opencontainers.image.licenses="MIT"

WORKDIR /workspace

# System deps for WebUI
RUN apt-get update && apt-get install -y --no-install-recommends \
      git-lfs ffmpeg libgl1 libglib2.0-0 curl \
  && git lfs install \
  && rm -rf /var/lib/apt/lists/*

# Clone Automatic1111 repo at the official v1.10.1 tag (shallow)
ARG A1111_TAG="v1.10.1"
RUN git clone --depth 1 --branch "${A1111_TAG}" \
      https://github.com/AUTOMATIC1111/stable-diffusion-webui.git \
      /workspace/stable-diffusion-webui

# Prevent A1111 from re-pinning Torch/TV/TA (we already have Torch 2.4.0 cu121 in base)
RUN sed -i '/^torch[^a-zA-Z]/d;/^torchvision[^a-zA-Z]/d;/^torchaudio[^a-zA-Z]/d' \
      /workspace/stable-diffusion-webui/requirements_versions.txt

# Pre-install python deps (Torch already present)
RUN pip install --no-cache-dir -r /workspace/stable-diffusion-webui/requirements_versions.txt \
 && pip install --no-cache-dir -r /workspace/stable-diffusion-webui/requirements.txt

# Configurable runtime knobs
ENV WEBUI_PORT=7860 \
    WEBUI_ARGS="--xformers --enable-insecure-extension-access --gradio-queue --theme dark"

# Add start script
COPY a1111/a1111-start.sh /usr/local/bin/a1111-start.sh
RUN chmod +x /usr/local/bin/a1111-start.sh

# Expose WebUI port
EXPOSE 7860

# (Optional) Healthcheck (works best when --api is enabled in WEBUI_ARGS)
HEALTHCHECK --interval=30s --timeout=5s --retries=10 CMD \
  curl -fsS "http://127.0.0.1:${WEBUI_PORT}/sdapi/v1/sd-models" >/dev/null || exit 1

# Default entry
CMD ["/usr/local/bin/a1111-start.sh"]
