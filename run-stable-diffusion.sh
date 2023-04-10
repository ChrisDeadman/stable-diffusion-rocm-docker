#!/bin/sh

docker run -it --rm --network=host --device=/dev/kfd --device=/dev/dri --group-add=video --ipc=host --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
       -v $(pwd)/models:/app/models/Stable-diffusion \
       -v $(pwd)/outputs:/app/outputs \
       --name stable-diffusion \
       deads-inc/stable-diffusion-rocm-docker:latest
