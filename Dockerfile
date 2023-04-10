# Use the archlinux base image from Docker Hub
FROM archlinux

# Set the working directory
WORKDIR /app

# Add the arch4edu repository to pacman
RUN echo '[arch4edu]' >> /etc/pacman.conf && \
    echo 'SigLevel = Never' >> /etc/pacman.conf && \
    echo 'Server = https://mirror.sunred.org/arch4edu/$arch' >> /etc/pacman.conf && \
    pacman -Syu --noconfirm --needed archlinux-keyring && \
    pacman-key --init && \
    pacman-key --populate archlinux

# Install packages
RUN pacman -Syu --noconfirm --needed base-devel git python python-virtualenv python-pytorch-opt-rocm python-torchvision-rocm && \
    pacman -Scc --noconfirm

# Clone the repository
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git . && \
    rm -Rf ./.git

# Create a Python virtual environment with --system-site-packages
RUN python -m venv --system-site-packages venv

# Activate the virtual environment and install requirements
RUN source venv/bin/activate && \
    pip install --upgrade --no-cache-dir pip wheel && \
    pip install --upgrade --no-cache-dir xformers && \
    pip install --no-cache-dir -r requirements.txt && \
    find /app/venv -name "__pycache__" -type d -exec rm -r {} + && \
    rm -rf /root/.cache/pip

# Trigger pre-install of requirements
RUN source venv/bin/activate && \
    venv/bin/python launch.py --skip-torch-cuda-test --no-download-sd-model || true

# Create a volume for models
VOLUME /app/models/Stable-diffusion

# Create a volume for outputs
VOLUME /app/outputs

# Expose the web-ui port
EXPOSE 7860

# Set the default command to run when starting the container
CMD ["venv/bin/python", "launch.py", "--skip-version-check", "--skip-install", "--no-download-sd-model"]
