# sd-webui-hub

[![Base v0.1.2](https://img.shields.io/badge/base-v0.1.2-blue?logo=docker&label=base)](https://github.com/freeradical16/sd-webui-hub/pkgs/container/sd-webui-hub/533618479?tag=base-v0.1.2)
[![A1111 v0.2.0](https://img.shields.io/badge/a1111-v0.2.0-purple?logo=docker&label=a1111)](https://github.com/freeradical16/sd-webui-hub/pkgs/container/sd-webui-hub/534121884?tag=a1111-v0.2.0)

A lean, reproducible **hub of GPU container images** for Stable Diffusion tooling.  
Built for cloud GPU hosts (e.g., **RunPod**) with **CUDA 12.1 + PyTorch** and **JupyterLab** as the base.

---

## 📦 Images & Tags

| Component | Stable tags (examples)                           | Latest pointer    | Dev/Test tags (examples)         | Pull example |
|----------:|--------------------------------------------------|------------------|----------------------------------|--------------|
| **Base**  | `base-v0.1.2`, `base-0.1`                       | `base-latest`    | `base-dev`, `base-test-2025-10-03` | `docker pull ghcr.io/freeradical16/sd-webui-hub:base-v0.1.2` |
| **A1111** | `a1111-v0.2.0`, `a1111-0.2`                     | `a1111-latest`   | `a1111-dev`, `a1111-test-2025-10-03` | `docker pull ghcr.io/freeradical16/sd-webui-hub:a1111-v0.2.0` |

**Notes**
- `*-latest` moves **only** on a component’s release. Dev/test builds never touch `latest`.
- Component images can pin a specific base, e.g. `FROM ...:base-v0.1.2` for reproducibility.

---

## 🚀 Quick Start on RunPod

### Base (JupyterLab only)
1. Use this image:
   ```
   ghcr.io/freeradical16/sd-webui-hub:base-latest
   ```
2. Expose port **8888**.
3. (Optional) Mount a volume at `/workspace`.

When the pod starts, click **port 8888** → it redirects to **/lab**.  
A sample notebook `/workspace/environment_check.ipynb` verifies Python/Torch/CUDA and runs a small GPU test.

### Automatic1111 (WebUI + JupyterLab)
1. Use this image:
   ```
   ghcr.io/freeradical16/sd-webui-hub:a1111-latest
   ```
2. Expose ports **7860** (WebUI) and **8888** (JupyterLab).
3. (Optional) Mount a volume at `/workspace`.

On boot:
- The WebUI starts on **7860** with RunPod-friendly flags (`--listen`, `--api`, no auto-update).
- JupyterLab starts on **8888** with the same GPU check notebook copied to `/workspace`.

---

## 🔧 Environment Variables

| Variable         | Default            | Applies to | Purpose                                                      |
|------------------|--------------------|------------|--------------------------------------------------------------|
| `JUPYTER_PORT`   | `8888`             | Base/A1111 | Port for JupyterLab                                          |
| `JUPYTER_ROOT`   | `/workspace`       | Base/A1111 | Root directory for Jupyter file browser                      |
| `JUPYTER_TOKEN`  | *(empty)*          | Base/A1111 | If empty → **no auth**. Set a value to require login.        |
| `WEBUI_PORT`     | `7860`             | A1111      | Port for the WebUI                                           |
| `WEBUI_ROOT`     | `/workspace/a1111` | A1111      | Data dir for WebUI (models, outputs, extensions)             |
| `WEBUI_ARGS`     | *(empty)*          | A1111      | Extra CLI args passed to `launch.py` (e.g. `--xformers --api`) |

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
docker pull ghcr.io/freeradical16/sd-webui-hub:base-v0.1.2
docker pull ghcr.io/freeradical16/sd-webui-hub:base-0.1
docker pull ghcr.io/freeradical16/sd-webui-hub:base-latest

# A1111 (stable)
docker pull ghcr.io/freeradical16/sd-webui-hub:a1111-v0.2.0
docker pull ghcr.io/freeradical16/sd-webui-hub:a1111-0.2
docker pull ghcr.io/freeradical16/sd-webui-hub:a1111-latest

# Dev/Test (manual builds)
docker pull ghcr.io/freeradical16/sd-webui-hub:base-dev
docker pull ghcr.io/freeradical16/sd-webui-hub:a1111-dev
```

---

## 🗺 Roadmap

- Add notebooks to help users install models, LoRAs, and extensions more easily  
- Add **Forge** image (`forge-*`)  
- Add **SD.Next** image (`sdnext-*`)  
- Add **ComfyUI** image (`comfyui-*`)  
- Add **SwarmUI** image (`swarmui-*`)  
- Optional “build-all” workflow for monorepo snapshots

---

## 📄 License

MIT © 2025 freeradical16
