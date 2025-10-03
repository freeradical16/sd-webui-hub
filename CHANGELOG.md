# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),  
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]
- Upcoming support for `forge`, `comfyui` layers on top of the base image.
- Additional notebooks and tooling.

---

## [a1111-v0.1.0] - 2025-10-04
### Added
- First stable release of the **Automatic1111 WebUI image**.
- Built on `base-v0.1.1` (CUDA 12.1.1, PyTorch 2.4.0).
- AUTOMATIC1111 pinned at upstream tag **v1.10.1**.
- Preinstalled extras:
  - `xformers==0.0.27.post2` (CUDA 12.1 build)
  - `hf_transfer` (fast Hugging Face downloads)
- Persists models, outputs, configs, and extensions under `/workspace/a1111`.

### Usage
- Image: `ghcr.io/freeradical16/sd-webui-hub:a1111-latest`
- Expose port **7860**.
- Mount volume at `/workspace`.

---

## [base-v0.1.1] - 2025-10-03
### Changed
- Release workflow now uses **component-scoped tags** (`base-v*.*.*`) so base can be released independently of other images.
- Ensured `base-latest` only updates on **base releases** (not on dev/test builds).
- Improved workflow metadata consistency (explicit labels, provenance).

---

## [v0.1.0] - 2025-10-02
### Added
- First stable release of **`sd-webui-hub` base image**.
- CUDA 12.1.1 + cuDNN8 runtime (Ubuntu 22.04).
- PyTorch 2.4.0 (cu121 wheels: torch, torchvision, torchaudio).
- JupyterLab 4.2.5 + Notebook 7.2.1 with proxy-friendly defaults.
- LSP support: `jupyterlab-lsp` + `python-lsp-server`.
- Example notebook `environment_check.ipynb` (checks CUDA, GPU, `nvidia-smi`).

### Fixed
- Removed bad `LabApp.extension_manager = False` config (caused JL4 warnings).
- Disabled Extension Manager UI via `overrides.json` (cleaner, reproducible builds).
- RunPod proxy config: `/` now redirects automatically to `/lab`.

---

[Unreleased]: https://github.com/freeradical16/sd-webui-hub/compare/a1111-v0.1.0...HEAD
[a1111-v0.1.0]: https://github.com/freeradical16/sd-webui-hub/releases/tag/a1111-v0.1.0
[base-v0.1.1]: https://github.com/freeradical16/sd-webui-hub/releases/tag/base-v0.1.1
[v0.1.0]: https://github.com/freeradical16/sd-webui-hub/releases/tag/v0.1.0
