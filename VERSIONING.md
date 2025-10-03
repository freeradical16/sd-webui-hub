# Versioning Guide (SemVer for sd-webui-hub)

This repo publishes **multiple container images** (components), each with its **own version stream** using [Semantic Versioning](https://semver.org/) `vX.Y.Z`.

- Components today: **base**, **a1111** (more later: forge, comfyui, …).
- Example tags: `base-v0.1.1`, `a1111-v0.1.0`.
- **Each component is versioned independently.** Adding or changing one component does **not** force a version bump for others.

---

## 1) What the version numbers mean

Use SemVer per component:

| Part | Meaning | When to bump |
|---:|---|---|
| **X** (major) | Breaking change for that image | Changes that require users to adapt (e.g., CUDA/OS jump, default flags incompatible, folder layout change) |
| **Y** (minor) | Backward-compatible features/improvements | New supported features, enhancements, extra tools/extensions, performance boosts |
| **Z** (patch) | Backward-compatible fixes/chores | Bug fixes, small dependency bumps, workflow tweaks, doc-only or non-breaking defaults |

**Rule of thumb:**  
- If users **must change** how they run/pull/use the image → bump **major**.  
- If it’s an **additive improvement** → bump **minor**.  
- If it’s a **safe fix** → bump **patch**.

---

## 2) Upstream versions vs. Image versions

Each image may **pin an upstream project** (e.g., Automatic1111). Upstream versions do **not** dictate your image version.

- Upstream (inside Dockerfile):  
  ```dockerfile
  ARG A1111_TAG="v1.10.1"  # upstream version
  ```
- Image (published to GHCR):  
  ```
  ghcr.io/...:a1111-v0.1.0  # your first image release
  ```

You **must** call out which upstream you pinned in release notes, but your image’s SemVer reflects **your** changes.

---

## 3) Tag naming and latest pointers

Each component publishes:

- `component-vX.Y.Z` (immutable, release)  
- `component-X.Y` (floating minor)  
- `component-latest` (latest stable for that component)  
- Dev/test builds: `component-dev`, `component-test-YYYYMMDD` (never move `*-latest`)

**Examples**
```
base-v0.1.1, base-0.1, base-latest
a1111-v0.1.0, a1111-0.1, a1111-latest
```

---

## 4) Release triggers & dev builds

- **Release (per component):**  
  - Base: push a Git tag `base-vX.Y.Z` → builds/pushes `base-vX.Y.Z`, `base-X.Y`, `base-latest`.  
  - A1111: push `a1111-vX.Y.Z` → builds/pushes `a1111-vX.Y.Z`, `a1111-X.Y`, `a1111-latest`.  
  - Future components follow the same pattern.

- **Dev/Test builds (manual):**  
  - Run the component’s `*-dev` workflow with an input (e.g., `dev`, `test-2025-10-03`).  
  - Produces `component-<input>` only. **Never** touches `*-latest`.

---

## 5) When to bump for common changes

### Base image
- **Major**: switch CUDA/driver base (e.g., `12.1` → `12.4`), change OS base (Ubuntu 22.04 → 24.04), break default paths or entrypoints.
- **Minor**: add JupyterLab features/extensions, add system deps (e.g., `ffmpeg`), enable optional tooling.
- **Patch**: fix start flags, workflow fixes, security patches with no API change.

### A1111 image
- **Major**: change default launch behavior incompatibly (e.g., port/paths/flags breaking existing templates), restructure volumes, remove critical features.
- **Minor**: bump pinned upstream tag (e.g., A1111 `v1.10.1` → `v1.11.0`), add optional extensions or quality-of-life flags.
- **Patch**: fix startup script, small dependency pin tweaks, doc/workflow cleanups.

> **Note:** Bumping A1111’s **upstream** from `v1.10.1` to `v1.11.0` is **usually a minor** image bump, provided defaults remain compatible.

---

## 6) Compatibility & pinning

Downstream images should **pin** a known-good base:

```dockerfile
# In a1111/Dockerfile
FROM ghcr.io/freeradical16/sd-webui-hub:base-v0.1.1
```

Templates (e.g., RunPod) can choose:
- **Stable**: `component-vX.Y.Z` (fully pinned) or `component-X.Y` (float within minor)
- **Latest stable**: `component-latest`
- **Dev**: `component-dev` (for experiments; not guaranteed stable)

---

## 7) Changelog & releases

Keep changes human-friendly in `CHANGELOG.md` using sections per component when relevant:

```markdown
## [base-v0.1.1] - 2025-10-03
### Changed
- Release workflow scoped to base-v* (independent releases).
```

Release notes should mention:
- The **component** and version (`base-v0.1.1`, `a1111-v0.1.0`)
- The **upstream tag/commit** used (if applicable)
- Highlights (Added/Changed/Fixed)
- Pull examples

---

## 8) FAQ

**Q: If I add A1111, does Base bump?**  
A: No. Only bump Base when Base changes.

**Q: Can I sync all components under one repo tag (e.g., `v0.3.0`)?**  
A: You can add an optional “build-all” workflow for coordinated snapshots, but normal releases remain **component-scoped**.

**Q: What if I accidentally push a dev build as latest?**  
A: Our workflows never move `*-latest` from dev. If it happens, re-run the release workflow for that component to reset `*-latest`.

---

## 9) Cheatsheet

- First release of a component: **`component-v0.1.0`**
- Bug fix: **`component-v0.1.1`**
- New feature, backwards-compatible: **`component-v0.2.0`**
- Breaking change: **`component-v1.0.0`**

Always include: `component-vX.Y.Z`, `component-X.Y`, `component-latest`.
