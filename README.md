# sd-webui-hub

**All-in-one Stable Diffusion WebUI hub** — a containerized image with AUTOMATIC1111, JupyterLab, and nginx reverse proxy, managed by supervisord.  
Designed for cloud GPU platforms (e.g., RunPod) with a clean flat file structure and GitHub Actions for automatic builds to GHCR.

## Features

- **AUTOMATIC1111** (pinned at `v1.10.1`) running on port 7860
- **JupyterLab** (auth disabled in this image) running on port 8888
- **nginx** reverse proxy on port 3000
  - `/` → A1111
  - `/jupyter/` → JupyterLab
- **supervisord** keeps all services alive (PID 1)
- **Torch 2.4.0 (CUDA 12.1)** + **xformers 0.0.27.post2**
- OpenCV runtime libraries included
- Clean flat repo structure, no `scripts/` folder
- Automatic GitHub Actions workflow to build & push images to GHCR

## RunPod usage

**Ports to expose:**
- `3000` (recommended front door)
- `7860` (optional direct A1111)
- `8888` (optional direct Jupyter)

**Volume:**
- Mount at `/workspace`

**Environment variables:**
```
DATA_DIR=/workspace/a1111-data
WEBUI_ARGS=--listen --api --xformers
# Jupyter auth is disabled in this build
```

### Access

- A1111 → `…:3000/`
- JupyterLab → `…:3000/jupyter/`
- Direct (debug):
  - A1111 → `…:7860/`
  - JupyterLab → `…:8888/`

## Build locally

```
docker build -t sd-webui-hub:local .
docker run --gpus all -p 3000:3000 -p 7860:7860 -p 8888:8888 \
  -v $PWD/workspace:/workspace \
  sd-webui-hub:local
```

## Security note

⚠️ **Jupyter auth is disabled** in this image (`--ServerApp.token='' --ServerApp.password=''`).  
Do not expose port 8888 or `/jupyter/` to the open internet. For shared/public use, re-enable auth by setting `JUPYTER_TOKEN` and removing `--ServerApp.disable_check_xsrf=True`.

## Roadmap

Future versions of **sd-webui-hub** will expand beyond AUTOMATIC1111 + Jupyter to include:

- **ComfyUI** (graph-based workflows)
- **Forge** (A1111 fork with more performance features)
- **Swarm UI** (multi-backend orchestration)
- **SD.Next** (alternative WebUI)
- More WebUI frontends as the ecosystem evolves

---

## Versioning

- Tags follow [Semantic Versioning](https://semver.org/), prefixed with `v`
- Example: `v0.1.0`, `v0.2.0`, etc.
- GitHub Actions pushes `:main` and `:<commit-sha>` images to GHCR
