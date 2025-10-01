# 🧩 SD WebUI Hub — Base Image

This repository contains a modular **base Docker image** for GPU workflows with JupyterLab preconfigured.  
It’s designed to be the foundation for running Stable Diffusion WebUI variants (A1111, Forge, ComfyUI, etc.) on cloud GPU services.

## 🚀 Current Status
- ✅ **Base image** with CUDA 12.1, PyTorch, and JupyterLab
- ✅ Auto-starts JupyterLab on port **8888**
- ✅ Seeds an example notebook: `environment_check.ipynb`
- ⚠️ No authentication if `JUPYTER_TOKEN` is left unset (default).  
  For public use, set `JUPYTER_TOKEN` to a secure value in your template.

Future releases will add A1111, Forge, ComfyUI, and others, all built **FROM** this base.

---

## 🔧 Using on RunPod

1. Build & push your image (or pull from GHCR if released):
   ```
   ghcr.io/freeradical16/sd-webui-hub:base-dev
   ```

2. In your RunPod template:
   - **Image:** `ghcr.io/freeradical16/sd-webui-hub:base-dev`
   - **Expose port:** `8888`
   - **Start command:** leave empty (auto-starts Jupyter)
   - **Volume mount:** `/workspace`
   - **Env variables:**
     ```env
     JUPYTER_PORT=8888
     JUPYTER_ROOT=/workspace
     JUPYTER_TOKEN=   # blank = no auth; set to enable token login
     ```

3. Launch pod → open port 8888 → you should land in JupyterLab.

---

## 🧪 Test Your GPU
Open `environment_check.ipynb` in JupyterLab and run all cells.  
This will print Python, PyTorch, CUDA versions, GPU name, and run a simple CUDA matmul.

---

## 📂 Repo Layout
```
sd-webui-hub/
├── base/
│   ├── Dockerfile         # Base image definition
│   ├── base-start.sh      # Startup script (seeds notebook + starts Jupyter)
├── notebooks/
│   └── environment_check.ipynb  # Example GPU check notebook
├── .github/workflows/
│   └── build-base.yml     # GitHub Actions CI for builds
├── .gitignore
└── README.md
```

---

## 🌐 Other Cloud Providers (future)
The base image is cloud-agnostic.  
Later, additional start scripts (e.g. `start-runpod.sh`, `start-vast.sh`, `start-paperspace.sh`) can be added here if specific providers require custom initialization logic.

---

## 📜 License
MIT License © 2025 [Your Name or Handle]  
See [LICENSE](LICENSE) for details.
