# Changelog

All notable changes to this project will be documented here.  
Versioning follows the [VERSIONING.md](VERSIONING.md) guide: **MAJOR.MINOR.PATCH**.

---

## [Unreleased]

### Planned
- Add notebooks to help users install models, LoRAs, and extensions more easily.
- Add new UI images:
  - Forge (`forge-*`)
  - SD.Next (`sdnext-*`)
  - ComfyUI (`comfyui-*`)
  - SwarmUI (`swarmui-*`)
- Optional “build-all” workflow for monorepo snapshots.

---

## [a1111-v0.3.0] - 2025-10-15
### Added
- Baked in dependency stack for ReActor (InsightFace + ONNX) and OpenPose Editor (`basicsr`).
- Added optional ControlNet SVG preprocessor support (`libcairo2-dev`, `gcc`, `pkg-config`).
- Added ipywidgets/tqdm/request/huggingface_hub to support all included Jupyter notebooks.

### Changed
- Based on `base-v0.1.2` image (CUDA 12.1 + PyTorch 2.4).
- Simplified notebook installation flow; all notebooks auto-copied to `/workspace` on first boot.

### Fixed
- Eliminated runtime errors for InsightFace, OpenPose, and ControlNet preprocessors.
- Reduced console noise from missing extension dependencies.

---

## [base-v0.1.2] - 2025-10-14  
**Highlights:** Environment notebook isolation; leaner base build.

### Added
- `environment_check.ipynb` copied into `/opt/examples/` for seeding.
- On first Jupyter start, the notebook is placed into `/workspace` if missing.

### Changed
- Base Dockerfile now copies **only** the environment notebook (other notebooks move to A1111/derivative images).
- Clearer separation of responsibilities: base stays minimal; app images own their notebooks.

### Fixed
- Prevented accidental inclusion of extra notebooks.
- Slightly reduced build context and image footprint.

### Tags
- `base-v0.1.2`
- `base-0.1`
- `base-latest`

---

## [a1111-v0.2.0] - 2025-10-03  
**Highlights:** A1111 + JupyterLab combined into one container (multi-UI support).

### Added
- **JupyterLab** (4.2.5 + Notebook 7.2.1) bundled with A1111, running under `supervisord` on port **8888**.
- Auto-seeds `environment_check.ipynb` into `/workspace` for Python/Torch/CUDA verification.
- New environment variables:
  - `WEBUI_ROOT` (default `/workspace/a1111`) for data/models/extensions
  - `WEBUI_ARGS` for extra CLI args (e.g. `--xformers --api`)

### Changed
- Both A1111 (port 7860) and JupyterLab (port 8888) now managed by **supervisord** for stability and auto-restart.
- Logging streamlined to stdout/stderr (avoids rotation/seek errors).
- Jupyter launched with `--allow-root`, `--default_url=/lab`, and proxy-friendly flags.
- Extension Manager disabled globally via `overrides.json` for reproducibility.

### Roadmap Alignment
- First step toward a multi-UI hub: Base + A1111 now run side-by-side.
- Future releases will add notebooks for model/extension installs, plus new UIs (Forge, SD.Next, ComfyUI, SwarmUI).

### Tags
- `a1111-v0.2.0`
- `a1111-0.2`
- `a1111-latest`

---

## [a1111-v0.1.0] - 2025-10-02  
**Highlights:** First A1111 image (WebUI only, no Jupyter).

### Added
- First release of **Automatic1111 WebUI** container.
- Based on `base-v0.1.1`.
- Includes:
  - Stable Diffusion WebUI **v1.10.1** cloned from upstream.
  - Installed `requirements_versions.txt` + `requirements.txt`.
  - Torch/CUDA stack inherited from base image.
- Launch script starts A1111 on **port 7860** with:
  - `--listen`  
  - `--enable-insecure-extension-access`  
  - `--skip-torch-cuda-test`  
  - `--skip-update`

### Changed
- Jupyter was **not included** in this release — WebUI-only container.

### Roadmap Alignment
- Establishes the first A1111 container on top of the base.
- Proved viability of running WebUI cleanly inside RunPod.

### Tags
- `a1111-v0.1.0`

---

## [base-v0.1.1] - 2025-10-02  
**Highlights:** Stable base with PyTorch + JupyterLab (reproducible, proxy-safe).

### Added
- Base image with **CUDA 12.1.1 + cuDNN8** (Ubuntu 22.04 runtime).
- **PyTorch 2.4.0** stack (`torch`, `torchvision`, `torchaudio` cu121 wheels).
- **JupyterLab 4.2.5** + **Notebook 7.2.1** preinstalled.
- Lightweight language server support via `jupyterlab-lsp` + `python-lsp-server`.
- Auto-seeds `environment_check.ipynb` into `/workspace` on first boot.

### Changed
- Configured Jupyter to auto-redirect `/` → `/lab`.
- Disabled JupyterLab Extension Manager globally via `overrides.json` to reduce log noise and ensure reproducibility.
- Added proxy-safe defaults (`--allow-origin=*`, `--trust-xheaders`).

### Roadmap Alignment
- Serves as the foundation for all future images (A1111, Forge, SD.Next, ComfyUI, SwarmUI).
- Establishes reproducible, lightweight base layer for Stable Diffusion UIs.

### Tags
- `base-v0.1.1`
- `base-0.1`
- `base-latest`

---

## [base-v0.1.0] - 2025-10-01  
**Highlights:** First working base image (GPU + JupyterLab).

### Added
- Initial working **Base image** with:
  - CUDA 12.1.1 + cuDNN8 runtime
  - PyTorch 2.4.0 (cu121 wheels)
  - JupyterLab + Notebook (basic setup)
- Verified environment notebook included (`environment_check.ipynb`).

### Changed
- Jupyter ran in foreground (`CMD jupyter lab ...`).
- No supervisord, single-service only.

### Roadmap Alignment
- First milestone to prove GPU + JupyterLab integration worked.
- Provided a functional starting point for layering other UIs.

### Tags
- `base-v0.1.0`
