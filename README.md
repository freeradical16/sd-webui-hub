## 🧩 Base Image Quickstart (`v0.1.0-base`)

The **base image** provides a clean CUDA + PyTorch + JupyterLab environment that higher-level WebUI images (A1111, Forge, ComfyUI, etc.) will build on.

### Using on RunPod

1. In your RunPod template, set the image to:
   ```
   ghcr.io/freeradical16/sd-webui-hub:base-v0.1.0
   ```

2. Template settings:
   - **Expose port:** `8888`
   - **Volume mount:** `/workspace`
   - **Start command:** leave empty (container auto-starts JupyterLab)
   - **Env variables:**
     ```env
     JUPYTER_PORT=8888
     JUPYTER_ROOT=/workspace
     JUPYTER_TOKEN=   # blank = no auth; set a value to enable token login
     ```

3. Launch your pod, then open the `8888` port from the RunPod UI to access JupyterLab.

---

### Test Notebook

The image includes a built-in notebook:  
- `environment_check.ipynb`  
  Located under `/workspace` on container start.  
  - Prints Python / PyTorch / CUDA versions  
  - Runs `nvidia-smi` if available  
  - Executes a small GPU matmul test  

Simply **run the first code cell** to see all environment checks.
