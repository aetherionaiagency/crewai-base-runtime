# Base image
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    ffmpeg \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set python3.11 as default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

# Manually install pip for python3.11
RUN wget https://bootstrap.pypa.io/get-pip.py && python3.11 get-pip.py && rm get-pip.py

# Install Python packages
RUN python3.11 -m pip install \
    openai-whisper \
    crewai \
    pydub \
    requests \
    python-dotenv \
    boto3 \
    asana \
    rich \
    tiktoken \
    sentence-transformers \
    transformers \
    torchaudio \
    torch==2.1.0 --index-url https://download.pytorch.org/whl/cu118

# Set workdir
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
