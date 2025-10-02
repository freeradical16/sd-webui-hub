# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),  
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]
- Upcoming support for `a1111`, `forge`, `comfyui` layers on top of the base image.
- Additional notebooks and tooling.

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

[Unreleased]: https://github.com/freeradical16/sd-webui-hub/compare/v0.1.0...HEAD
[v0.1.0]: https://github.com/freeradical16/sd-webui-hub/releases/tag/v0.1.0
