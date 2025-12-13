# Local qmk_cli Docker Image

## Overview

This repository is intended to **build a local-only `qmk_cli:local` Docker image** for use in a development environment.

In recent versions of `qmk_cli`, `make` no longer works correctly. To avoid this issue, this repository builds a Docker image based on **`qmk_base_container:1.1.8`, which has been confirmed to work reliably**.

This setup is **not intended for GitHub Actions or distribution**. It is designed specifically for **local QMK firmware builds** without modifying the host environment.

---

## Build

Run the following command:

```sh
make
```

This will create the following Docker image **locally only**:

```text
qmk_cli:local
```

During the build process, the following steps are performed automatically:

- Fetch `qmk_cli` as a git submodule
- Execute `build-docker.sh`

---

## Usage with qmk_firmware

To use this local image with `qmk_firmware`, replace the image reference in `docker_cmd.sh`.

Specifically, replace `ghcr.io/qmk/qmk_cli` with the locally built `qmk_cli` image.

You can do this automatically with the following command:

```sh
sed -i.bak 's|ghcr.io/qmk/qmk_cli[^ ]* |qmk_cli |g' util/docker_cmd.sh
```

This will:

- Create a backup file: `util/docker_cmd.sh.bak`
- Update `docker_cmd.sh` to use the local `qmk_cli` image

After this change, QMK commands executed via `docker_cmd.sh` will run using `qmk_cli:local`.

---

## Notes

- This Docker image is intended for **temporary, local use only**
- No images are pushed to Docker Hub or GHCR
- This repository may become unnecessary once the upstream `qmk_cli` issue is resolved
