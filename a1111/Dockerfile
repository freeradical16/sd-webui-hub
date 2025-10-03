# ---- Automatic1111 WebUI build ----
FROM ghcr.io/freeradical16/sd-webui-hub:base-latest

LABEL org.opencontainers.image.source="https://github.com/freeradical16/sd-webui-hub" \
      org.opencontainers.image.description="Automatic1111 Stable Diffusion WebUI v1.10.1 on top of sd-webui-hub base" \
      org.opencontainers.image.licenses="MIT"

WORKDIR /workspace

# System deps for WebUI
RUN apt-get update && apt-get install -y --no-install-recommends \
      git-lfs ffmpeg libgl1 libglib2.0-0 \
  && rm -rf /var/lib/apt/lists/* \
  && git lfs install

# Clone Automatic1111 repo at the official v1.10.1 tag
ARG A1111_TAG="v1.10.1"
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /workspace/stable-diffusion-webui \
  && cd /workspace/stable-diffusion-webui \
  && git checkout ${A1111_TAG}

# Pre-install requirements (Torch already present in base image)
RUN pip install --no-cache-dir -r /workspace/stable-diffusion-webui/requirements_versions.txt \
 && pip install --no-cache-dir -r /workspace/stable-diffusion-webui/requirements.txt

# Add start script
COPY a1111/a1111-start.sh /usr/local/bin/a1111-start.sh
RUN chmod +x /usr/local/bin/a1111-start.sh

# Expose WebUI port
EXPOSE 7860

# Default entry
CMD ["/usr/local/bin/a1111-start.sh"]
