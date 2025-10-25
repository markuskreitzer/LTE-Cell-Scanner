# LTE-Cell-Scanner build container (Ubuntu 22.04)
# Provides a reproducible environment to build the project with optional SDR backends.

ARG UBUNTU_VERSION=22.04
FROM ubuntu:${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive

# Base build dependencies and optional SDR libraries
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      cmake \
      pkg-config \
      git \
      libboost-all-dev \
      libitpp-dev \
      libfftw3-dev \
      liblapack-dev \
      libblas-dev \
      libncurses5-dev \
      # Optional SDR backends
      libhackrf-dev hackrf \
      librtlsdr-dev \
      libbladerf-dev \
      # Optional OpenCL headers (disable via -DUSE_OPENCL=0 if undesired)
      ocl-icd-opencl-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the project into the container
COPY . /app

# Configure which backends to enable at build time
ARG USE_HACKRF=1
ARG USE_RTLSDR=0
ARG USE_BLADERF=0
ARG USE_OPENCL=0

# Build
RUN mkdir -p build && \
    cd build && \
    cmake -DUSE_HACKRF=${USE_HACKRF} -DUSE_RTLSDR=${USE_RTLSDR} -DUSE_BLADERF=${USE_BLADERF} -DUSE_OPENCL=${USE_OPENCL} .. && \
    make -j"$(nproc)"

# Add built binaries to PATH for convenience
ENV PATH="/app/build/src:${PATH}"

# Default to an interactive shell so you can run CellSearch/LTE-Tracker manually
CMD ["bash"]

