# sd-webui-hub

[![Base Latest](https://img.shields.io/badge/base-v0.1.2-blue?logo=docker&label=base)](https://github.com/freeradical16/sd-webui-hub/pkgs/container/sd-webui-hub/533618479?tag=base-v0.1.2)
[![A1111 Latest](https://img.shields.io/badge/a1111-v0.3.0-purple?logo=docker&label=a1111)](https://github.com/freeradical16/sd-webui-hub/pkgs/container/sd-webui-hub/534121884?tag=a1111-v0.3.0)

A lean, reproducible **hub of GPU container images** for Stable Diffusion tooling.  
Built for cloud GPU hosts (e.g., **RunPod**) with **CUDA 12.1 + PyTorch 2.4** and **JupyterLab** as the base.

---

## 📦 Images & Tags

| Component | Stable tags (examples)                                      | Latest pointer                | Dev/Test tags (examples)         | Pull example |
|----------:|--------------------------------------------------------------|-------------------------------|----------------------------------|--------------|
| **Base**  | `base-v0.1.2`, `base-0.1`                                   | `base-latest`                 | `base-dev`, `base-test-2025-10-03` | `docker pull ghcr.io/freeradical16/sd-webui-hub:base-v0.1.2` |
| **A1111** | `a1111-v0.3.0`, `a1111-0.3`                                 | `a1111-latest`                | `a1111-dev`, `a1111-test-2025-10-03` | `docker pull ghcr.io/freeradical16/sd-webui-hub:a1111-v0.3.0` |

**Notes**
- `*-latest` moves **only** on a component’s release. Dev/test builds never touch `latest`.
- Component images can pin a specific base, e.g. `FROM ...:base-v0.1.2` for reproducibility.

---

## 🚀 Quick Start on RunPod

### Base (JupyterLab)
1. Use this image:
   ```
   ghcr.io/freeradical16/sd-webui-hub:base-latest
   ```
2. Expose port **8888**.
3. (Optional) Mount a volume at `/workspace`.

When the pod starts, click **port 8888** → it redirects to **/lab**.  
A sample notebook `/workspace/environment_check.ipynb` verifies Python/Torch/CUDA and runs a small GPU test.

### Automatic1111 (Web UI)
1. Use this image:
   ```
   ghcr.io/freeradical16/sd-webui-hub:a1111-latest
   ```
2. Expose port **7860** (A1111) and **8888** (JupyterLab from base, if you want it too).
3. (Optional) Mount a volume at `/workspace`.

The WebUI starts on **7860** with RunPod-friendly flags (`--listen`, no auto-update, proxy-safe).

---

## 🔧 Environment Variables

| Variable         | Default      | Purpose                                           |
|------------------|--------------|---------------------------------------------------|
| `JUPYTER_PORT`   | `8888`       | Port for JupyterLab                               |
| `JUPYTER_ROOT`   | `/workspace` | Root directory for Jupyter file browser           |
| `JUPYTER_TOKEN`  | *(empty)*    | If empty → **no auth**. Set a value to require login. |
| `WEBUI_PORT`     | `7860`       | (A1111) Port for the Web UI                       |
| `WEBUI_ROOT`     | `/workspace/a1111` | (A1111) Working directory                   |
| `WEBUI_ARGS`     | *(empty)*    | (A1111) Extra arguments for `launch.py`           |

> Security: for public/shared deployments, set a `JUPYTER_TOKEN`.

---

## 🧱 What’s in the Images

### Base (`base-v0.1.2`)
- **CUDA 12.1.1 + cuDNN8** (Ubuntu 22.04 runtime)  
- **PyTorch 2.4.0** (cu121 wheels)  
- **JupyterLab 4.2.5** + **Notebook 7.2.1**  
- **jupyterlab-lsp** + **python-lsp-server** (lightweight code intelligence)  
- **Extension Manager disabled** via `overrides.json` for reproducibility  
- **Example notebook** (`environment_check.ipynb`) seeded to `/workspace`  

### A1111 (`a1111-v0.3.0`)
- **Automatic1111 WebUI v1.10.1**
- **Built on `base-v0.1.2`**
- Preinstalled dependencies for:
  - **ReActor (InsightFace)** → `insightface`, `onnxruntime-gpu`, `albumentations`
  - **OpenPose Editor** → `basicsr`
  - **ControlNet SVG preprocessors** → `libcairo2-dev`, `pkg-config`, `gcc`
- **ipywidgets**, **tqdm**, **huggingface_hub**, **requests** for notebook UIs
- Launches **JupyterLab + WebUI** together via **supervisord**

---

## 🔒 Reproducibility

- Component images pin versions/tags:
  - **A1111** → official `v1.10.1`
  - **Base** → `base-v0.1.2` (CUDA 12.1 / Torch 2.4)
- Release tags are **immutable** (`*-vX.Y.Z` + shorthand minor `*-X.Y`)

---

## 🧪 Dev/Test vs Releases

| Type | Trigger | Tag Pattern | Notes |
|------|----------|--------------|-------|
| **Dev/Test builds** | Manual | `*-dev`, `*-test-YYYY-MM-DD` | never updates `*-latest` |
| **Releases** | Git tag push | `*-vX.Y.Z`, `*-X.Y` | updates the `*-latest` pointer |

---

## 📥 Pull Examples

```bash
# Base (stable)
docker pull ghcr.io/freeradical16/sd-webui-hub:base-v0.1.2
docker pull ghcr.io/freeradical16/sd-webui-hub:base-0.1
docker pull ghcr.io/freeradical16/sd-webui-hub:base-latest

# A1111 (stable)
docker pull ghcr.io/freeradical16/sd-webui-hub:a1111-v0.3.0
docker pull ghcr.io/freeradical16/sd-webui-hub:a1111-0.3
docker pull ghcr.io/freeradical16/sd-webui-hub:a1111-latest
```

---

## 🗺 Roadmap

- Add **ready-to-run notebooks** for installing models, LoRAs, embeddings, and extensions  
- Add **Forge**, **SD.Next**, **ComfyUI**, and **SwarmUI** component images  
- Optional “build-all” workflow for monorepo snapshots (single tag to build all components)

---

## 📄 License

MIT © 2025 freeradical16
