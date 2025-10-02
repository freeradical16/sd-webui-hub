# sd-webui-hub

Base container image for **Stable Diffusion WebUI stacks**.  
Designed to be lean, reproducible, and **RunPod-ready** with CUDA 12.1 + PyTorch + JupyterLab.

---

## 🚀 Quick Start (RunPod)

1. In RunPod, create a **Custom Template**.
2. Use this image (replace `latest` with a specific version if you want):

   ```
   ghcr.io/freeradical16/sd-webui-hub:base-latest
   ```

3. Expose port **8888**.  
4. (Optional) Mount a volume at `/workspace`.  

When the pod starts, click the **8888 port** → JupyterLab opens directly.  
A sample notebook `environment_check.ipynb` will be available under `/workspace`.

---

## 🔧 Environment Variables

| Variable         | Default      | Notes                                       |
|------------------|--------------|---------------------------------------------|
| `JUPYTER_PORT`   | `8888`       | Port JupyterLab listens on                  |
| `JUPYTER_ROOT`   | `/workspace` | Root directory for Jupyter file browser     |
| `JUPYTER_TOKEN`  | *(empty)*    | If empty → **no auth**. Set a string to require login. |

---

## 🧪 Example Notebook

The `environment_check.ipynb` notebook checks:
- Python & PyTorch versions
- CUDA availability
- `nvidia-smi` output
- Small GPU matmul test

Run it once to verify the GPU is working.

---

## 🛠️ Notes

- Based on `nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04`.  
- Includes **PyTorch 2.4.0 (cu121 wheels)**, JupyterLab 4.2.5, Notebook 7.2.1.  
- Extension Manager UI disabled (for reproducibility + smaller images).  
- Launches Jupyter with proxy-friendly flags for RunPod (auto-redirects `/` → `/lab`).  

---

## 🔮 Next Steps

This repo is the **base layer**. Planned additions:

- `a1111` → Automatic1111 Stable Diffusion WebUI  
- `forge` → SD.Next / Forge fork  
- `comfyui` → ComfyUI pipeline builder  
- Additional tools (InvokeAI, SwarmUI, etc.)

Each will build **on top of this base** using a layered Dockerfile + dedicated workflow.

If you only need a clean CUDA + Torch + JupyterLab base, **stick with this image**.  
If you want the full WebUI stack, watch for new tags/releases.

---

## 📦 Releases

We use [semantic versioning](https://semver.org/) for base images.  

| Tag          | Description                        |
|--------------|------------------------------------|
| `base-v0.1.0` | First stable release (CUDA 12.1, Torch 2.4.0, JupyterLab 4.2.5) |
| `base-latest` | Tracks the most recent stable release |
| `base-dev-*`  | Development/test builds (not guaranteed stable) |

To pin a specific version in RunPod, use the full tag:

```
ghcr.io/freeradical16/sd-webui-hub:base-v0.1.0
```
