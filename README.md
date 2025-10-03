# sd-webui-hub

[![Base v0.1.1](https://img.shields.io/badge/base-v0.1.1-blue?logo=docker&label=base)](https://github.com/freeradical16/sd-webui-hub/pkgs/container/sd-webui-hub/533618479?tag=base-v0.1.1)
[![A1111 v0.1.0](https://img.shields.io/badge/a1111-v0.1.0-purple?logo=docker&label=a1111)](https://github.com/freeradical16/sd-webui-hub/pkgs/container/sd-webui-hub/534121884?tag=a1111-v0.1.0)

A lean, reproducible **hub of GPU container images** for Stable Diffusion tooling.  
Built for cloud GPU hosts (e.g., **RunPod**) with **CUDA 12.1 + PyTorch** and **JupyterLab** as the base.

---

## 📦 Images & Tags

This repository publishes **separate images** per component with **component-scoped tags**.

| Component | Stable tags (examples)                                      | Latest pointer                | Dev/Test tags (examples)         | Pull example |
|----------:|--------------------------------------------------------------|-------------------------------|----------------------------------|--------------|
| **Base**  | `base-v0.1.1`, `base-0.1`                                   | `base-latest`                 | `base-dev`, `base-test-2025-10-03` | `docker pull ghcr.io/freeradical16/sd-webui-hub:base-v0.1.1` |
| **A1111** | `a1111-v0.1.0`, `a1111-0.1`                                 | `a1111-latest`                | `a1111-dev`, `a1111-test-2025-10-03` | `docker pull ghcr.io/freeradical16/sd-webui-hub:a1111-v0.1.0` |

**Notes**
- `*-latest` moves **only** on a component’s release. Dev/test builds never touch `latest`.
- Component images can pin a specific base, e.g. `FROM ...:base-v0.1.1` for reproducibility.

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
| `WEBUI_ROOT`     | `/workspace` | (A1111) Working directory                         |

> Security: for public/shared deployments, set a `JUPYTER_TOKEN`.

---

## 🛠 What’s in the Base image?

- **CUDA 12.1.1 + cuDNN8** (Ubuntu 22.04 runtime)  
- **PyTorch 2.4.0** (cu121 wheels: `torch`, `torchvision`, `torchaudio`)  
- **JupyterLab 4.2.5** + **Notebook 7.2.1**  
- **jupyterlab-lsp** + **python-lsp-server** (lightweight code intelligence)  
- Jupyter configured for proxies (auto-redirect `/` → `/lab`)  
- Extension Manager UI disabled via `overrides.json` (reproducible builds)  
- Example notebook seeded to `/workspace` on first boot

---

## 🔒 Reproducibility

- Component images pin versions/tags:
  - **Base** pinned at `base-v0.1.1`.
  - **A1111** pinned at the official upstream **v1.10.1**, released here as **`a1111-v0.1.0`**.
  - Components may explicitly `FROM ghcr.io/freeradical16/sd-webui-hub:base-vX.Y.Z`.
- Release tags are **immutable**: `*-vX.Y.Z`, plus shorthand minor `*-X.Y`.

---

## 🧪 Dev/Test vs Releases

- **Dev/Test builds** (manual):  
  - Tags like `base-dev`, `a1111-dev` (and timestamped variants).  
  - Never move `*-latest`.

- **Releases** (Git tag push):  
  - Base → `base-vX.Y.Z`, `base-X.Y`, move `base-latest`  
  - A1111 → `a1111-vX.Y.Z`, `a1111-X.Y`, move `a1111-latest`

You can release components **independently** (component-scoped tags).

---

## 📥 Pull Examples

```bash
# Base (stable)
docker pull ghcr.io/freeradical16/sd-webui-hub:base-v0.1.1
docker pull ghcr.io/freeradical16/sd-webui-hub:base-0.1
docker pull ghcr.io/freeradical16/sd-webui-hub:base-latest

# A1111 (stable)
docker pull ghcr.io/freeradical16/sd-webui-hub:a1111-v0.1.0
docker pull ghcr.io/freeradical16/sd-webui-hub:a1111-0.1
docker pull ghcr.io/freeradical16/sd-webui-hub:a1111-latest

# Dev/Test (manual builds)
docker pull ghcr.io/freeradical16/sd-webui-hub:base-dev
docker pull ghcr.io/freeradical16/sd-webui-hub:a1111-dev
```

---

## 🗺 Roadmap

- Add **Forge / SD.Next** image (component-scoped tags: `forge-*`)
- Add **ComfyUI** image
- Optional “build-all” workflow for monorepo snapshots (single tag to build all components)

---

## 📄 License

MIT © 2025 freeradical16
