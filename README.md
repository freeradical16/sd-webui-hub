# sd-webui-hub

**sd-webui-hub** is an all-in-one container project for Stable Diffusion WebUIs.  
This repo publishes a **shared base image** with CUDA, PyTorch, and JupyterLab pinned for stability.  
Other variants (A1111, Forge, ComfyUI, etc.) will build on this base in future releases.

---

## Base image

The base image includes:

- **OS & GPU stack**
  - Ubuntu 22.04 (LTS)
  - CUDA 12.1.1 + cuDNN 8 (runtime)
- **Python environment**
  - Python 3.10, pip, venv
  - PyTorch 2.4.0 (cu121), torchvision 0.19.0, torchaudio 2.4.0
  - xformers 0.0.27.post2
  - Common ML deps: safetensors, numpy, pillow, requests, tqdm, pyyaml, psutil, opencv-python-headless, transformers, diffusers, accelerate
- **Jupyter environment**
  - JupyterLab 4.2.x + Notebook 7.1.x + Jupyter Server 2.13.x
  - Pins included for stable async dependencies (`anyio`, `exceptiongroup`)

---

## How to pull

From GHCR:

```bash
# Latest from main branch
docker pull ghcr.io/freeradical16/sd-webui-hub:base-main

# Latest release tag
docker pull ghcr.io/freeradical16/sd-webui-hub:base-v0.1.0
```

---

## How to run locally

```bash
docker run --gpus all -it --rm \
  -p 8888:8888 \
  -v $PWD/workspace:/workspace \
  ghcr.io/freeradical16/sd-webui-hub:base-v0.1.0 \
  bash
```

Start Jupyter inside the container:

```bash
jupyter lab --no-browser --ip=0.0.0.0 --port=8888 \
  --NotebookApp.token="" --notebook-dir=/workspace
```

---

## Roadmap

Planned variants (built on this base):

- A1111 (Automatic1111 WebUI)
- Forge (A1111 performance fork)
- ComfyUI (graph-based workflow)
- SwarmUI (multi-backend orchestrator)
- SD.Next (modern fork)

---

## License

MIT © 2025 freeradical16
