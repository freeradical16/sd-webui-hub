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

## [a1111-v0.2.0] - 2025-10-03

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

## [base-v0.1.1] - 2025-10-02

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
