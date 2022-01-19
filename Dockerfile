FROM ubuntu:21.10

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --yes \
  bash-completion \
  build-essential \
  curl \
  git \
  libavcodec-dev \
  libavformat-dev \
  libavutil-dev \
  libcairo2-dev \
  libdrm-dev \
  libegl-dev \
  libgbm-dev \
  libgdk-pixbuf-2.0-dev \
  libgles-dev \
  libinput-dev \
  libjson-c-dev \
  libpango1.0-dev \
  libpixman-1-dev \
  libpng-dev \
  libsystemd-dev \
  libwayland-dev \
  libxcb-composite0-dev \
  libxcb-dri3-dev \
  libxcb-icccm4-dev \
  libxcb-present-dev \
  libxcb-render0-dev \
  libxcb-render-util0-dev \
  libxcb-res0-dev \
  libxcb-shm0-dev \
  libxcb-xinput-dev \
  libxkbcommon-dev \
  meson \
  pkg-config \
  sudo \
  wayland-protocols \
  xwayland
RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/local/bin
