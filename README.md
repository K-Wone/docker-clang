[![Layers](https://images.microbadger.com/badges/image/leavesask/llvm.svg)](https://microbadger.com/images/leavesask/llvm)
[![Version](https://images.microbadger.com/badges/version/leavesask/llvm.svg)](https://hub.docker.com/repository/docker/leavesask/llvm)
[![Commit](https://images.microbadger.com/badges/commit/leavesask/llvm.svg)](https://github.com/K-Wone/docker-llvm)
[![License](https://images.microbadger.com/badges/license/leavesask/llvm.svg)](https://github.com/K-Wone/docker-llvm)
[![Docker Pulls](https://img.shields.io/docker/pulls/leavesask/llvm?color=informational)](https://hub.docker.com/repository/docker/leavesask/llvm)
[![Automated Build](https://img.shields.io/docker/automated/leavesask/llvm)](https://hub.docker.com/repository/docker/leavesask/llvm)

# Supported tags

- `9`, `9.0.1`
- `8`, `8.0.0`
- `7`, `7.1.0`

# How to use

1. [Install docker engine](https://docs.docker.com/install/)

2. Pull the image
  ```bash
  docker pull leavesask/llvm:<tag>
  ```

3. Run the image interactively
  ```bash
  docker run -it --rm leavesask/llvm:<tag>
  ```

# How to build

The base image is [spack/ubuntu-bionic](https://hub.docker.com/r/spack/ubuntu-bionic).

## make

```bash
# Build an image for LLVM 9
make LLVM_VERSION="9"

# Build and publish the image
make release LLVM_VERSION="9"
```

Check `Makefile` for more options.

## docker build

As an alternative, you can build the image with `docker build` command.

```bash
docker build \
        --build-arg LLVM_VERSION="9" \
        --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
        --build-arg VCS_REF=`git rev-parse --short HEAD` \
        -t my-repo/llvm:latest .
```

Arguments and their defaults are listed below.

- `LLVM_VERSION`: The version of LLVM supported by ubuntu-bionic (defaults to `9`)
