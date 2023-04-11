# deads-inc/stable-diffusion-rocm-docker

Docker image that packages the [AUTOMATIC1111 fork Stable Diffusion WebUI](https://github.com/AUTOMATIC1111/stable-diffusion-webui), preconfigured with dependencies to run on AMD Radeon GPUs.

This image is based on **archlinux** and will have about 38GB when built (pytorch rocm needs a lot of disk space :expressionless:).

## Requirements

- Modern Radeon card (VEGA 56/64, Radeon RX 6000 series or newer)
- Modern Linux kernel with ROCM module (Kernel 5.10+)
- Docker

## Download models

Put models into `models/Stable-diffusion` subfolder, e.g. https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt.

## Build

```
docker build -t deads-inc/stable-diffusion-rocm-docker .
```

## Run

```
./run-stable-diffusion.sh
```
